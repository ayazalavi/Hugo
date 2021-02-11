package com.apps.client.juan.hugomed.activities;

import android.content.Context;
import android.content.Intent;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.drawable.BitmapDrawable;
import android.os.Bundle;
import android.text.SpannableString;
import android.text.Spanned;
import android.text.SpannedString;
import android.text.TextUtils;
import android.util.Log;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.Button;
import android.widget.TextView;

import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;
import androidx.core.widget.CompoundButtonCompat;
import androidx.core.widget.TextViewCompat;
import androidx.databinding.BindingAdapter;
import androidx.lifecycle.Observer;
import androidx.lifecycle.ViewModelProvider;

import com.apps.client.juan.hugomed.R;
import com.apps.client.juan.hugomed.data.entities.Doctor;
import com.apps.client.juan.hugomed.data.entities.DoctorWithSpecialities;
import com.apps.client.juan.hugomed.data.helpers.General;
import com.apps.client.juan.hugomed.data.helpers.HugoMedDatabase;
import com.apps.client.juan.hugomed.data.viewmodels.DoctorsViewModel;
import com.apps.client.juan.hugomed.data.viewmodels.OnBoardingViewModel;
import com.apps.client.juan.hugomed.databinding.DoctorsCardOfflineBinding;
import com.apps.client.juan.hugomed.databinding.DoctorsCardOnlineBinding;
import com.apps.client.juan.hugomed.databinding.DoctorslistingBinding;
import com.apps.client.juan.hugomed.helpers.SpannableHelper;
import com.apps.client.juan.hugomed.service.APIRequest;

import org.jetbrains.annotations.NotNull;

import java.io.BufferedInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Collections;
import java.util.List;
import java.util.Timer;
import java.util.TimerTask;

import okhttp3.Call;
import okhttp3.Callback;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.Response;
import okhttp3.ResponseBody;

public class DoctorsListing extends AppCompatActivity {
    private DoctorsViewModel viewModel;
    private DoctorslistingBinding doctorsListing;
    private Adapter adapter;
    Runnable runnable;
    public static DoctorWithSpecialities selectedDoctor;
    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        doctorsListing = DoctorslistingBinding.inflate(getLayoutInflater());
        setContentView(doctorsListing.getRoot());

        runnable = new Runnable() {
            @Override
            public void run() {
                viewModel.getAllDoctors().observe(DoctorsListing.this, new Observer<List<DoctorWithSpecialities>>() {
                    @Override
                    public void onChanged(List<DoctorWithSpecialities> doctors) {
                        Collections.sort(doctors, (o1, o2) -> {
                            return o1.doctor.waiting_time.waiting - o2.doctor.waiting_time.waiting;
                        });
                        adapter.mDoctors = doctors;
                        adapter.notifyDataSetChanged();
                    }
                });
            }
        };
        HugoMedDatabase.databaseWriteExecutor.execute(() -> {
            viewModel = new ViewModelProvider(this).get(DoctorsViewModel.class);
            runOnUiThread(runnable);
        });
        adapter = new Adapter(this);
        doctorsListing.grid.setAdapter(adapter);
        setSupportActionBar(doctorsListing.myToolbar);
        getSupportActionBar().setDisplayShowTitleEnabled(false);
        doctorsListing.myToolbar.setNavigationOnClickListener(v -> {
            finish();
        });
        tryStartingService();

    }

    @Override
    protected void onStart() {
        super.onStart();
        General.hide_bottom_nav(this);
        if (APIRequest.current_appointment != null) {
            new Timer().schedule(new TimerTask() {
                @Override
                public void run() {
                    Intent intent = new Intent(DoctorsListing.this, EnterConsultationSlideUp.class);
                    startActivity(intent);
                    overridePendingTransition(R.anim.slide_in, R.anim.slide_out);
                }
            }, 500);
        }
    }

    private void tryStartingService() {
        try {
            Intent intent = new Intent(this, APIRequest.class);
            startService(intent);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
        Intent intent = new Intent(this, APIRequest.class);
        stopService(intent);
    }

    public void showDialog(DoctorWithSpecialities doctor) {
        selectedDoctor = doctor;
        Intent intent = new Intent(this, ConsultationSlideup.class);
        startActivity(intent);
        overridePendingTransition(R.anim.slide_in, R.anim.slide_out);
    }

    public void gotoFAQs(View view) {
        Intent intent = new Intent(this, FAQListing.class);
        startActivity(intent);
        overridePendingTransition(R.anim.slide_in_left, R.anim.slide_out_left);
    }

    class Adapter extends BaseAdapter {

        private List<DoctorWithSpecialities> mDoctors;
        private Context mContext;
        Adapter(Context context) {
            mContext = context;
        }
        @Override
        public int getCount() {
            if (mDoctors == null) {
                return 0;
            }
            return mDoctors.size();
        }

        @Override
        public Object getItem(int position) {
            return mDoctors.get(position);
        }

        @Override
        public long getItemId(int position) {
            return mDoctors.get(position).doctor.id;
        }


        public void downloadPhoto (DoctorsCardOnlineBinding binding, String link, DoctorsCardOfflineBinding binding2) {
            Request request = new Request.Builder()
                    .url(String.format(link))
                    .get()
                    .build();
            Call call = new OkHttpClient().newCall(request);

            call.enqueue(new Callback() {
                @Override
                public void onFailure(@NotNull Call call, @NotNull IOException e) {

                }

                @Override
                public void onResponse(@NotNull Call call, @NotNull Response response) throws IOException {
                    ResponseBody in = response.body();
                    InputStream inputStream = in.byteStream();
                    BufferedInputStream bufferedInputStream = new BufferedInputStream(inputStream);
                    Bitmap bitmap= BitmapFactory.decodeStream(bufferedInputStream);
                    DoctorWithSpecialities doctor = binding != null ? binding.getDoctor() : binding2.getDoctor();
                    doctor.doctor.picture = new BitmapDrawable(getResources(), bitmap);
                    if (binding != null) {
                        binding.setDoctor(doctor);
                    } else {
                        binding2.setDoctor(doctor);
                    }
                }
            });
        }
        @Override
        public View getView(int position, View convertView, ViewGroup parent) {
            DoctorWithSpecialities doctor = (DoctorWithSpecialities)getItem(position);
            String link = "http://"+doctor.doctor.avatar;
            if (doctor.doctor.waiting_time.waiting == 0) {
                DoctorsCardOnlineBinding binding = DoctorsCardOnlineBinding.inflate(getLayoutInflater(), parent, false);
                binding.setDoctor(mDoctors.get(position));
                binding.setDoctorsListing(DoctorsListing.this);
                downloadPhoto(binding, link, null);
                return binding.getRoot();
            }
            else {
                DoctorsCardOfflineBinding binding = DoctorsCardOfflineBinding.inflate(getLayoutInflater(), parent, false);
                binding.setDoctor(mDoctors.get(position));
                String str = getResources().getQuantityString(R.plurals.disponsible_en, (int)(mDoctors.get(position).doctor.waiting_time.waiting/60.0), (int)(mDoctors.get(position).doctor.waiting_time.waiting/60.0));
                SpannableString str1 = SpannableHelper.shared.getSpannableString(str.substring(0, str.length()-6), R.style.doctors_card_center_text_offline_attr_1, DoctorsListing.this);
                SpannableString str2 = SpannableHelper.shared.getSpannableString(str.substring(str.length()-6), R.style.doctors_card_center_text_offline_attr_2, DoctorsListing.this);
                SpannedString str3 = (SpannedString) TextUtils.concat(str1, str2);
                binding.centerText.setText(str3, TextView.BufferType.SPANNABLE);
                binding.setDoctorsListing(DoctorsListing.this);
                downloadPhoto(null, link, binding);
                return binding.getRoot();
            }
        }

    }

    @BindingAdapter({"bind:style"})
    public static void setStyle(Button button, int resource){
        button.setTextAppearance(button.getContext(), resource);
    }

    @BindingAdapter({"bind:style"})
    public static void setStyle(TextView textView, int resource){
        textView.setTextAppearance(textView.getContext(), resource);
    }
}
