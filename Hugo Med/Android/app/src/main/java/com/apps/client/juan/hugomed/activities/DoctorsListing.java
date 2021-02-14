package com.apps.client.juan.hugomed.activities;

import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.text.SpannableString;
import android.text.Spanned;
import android.text.SpannedString;
import android.text.TextUtils;
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
import com.apps.client.juan.hugomed.data.helpers.HugoMedDatabase;
import com.apps.client.juan.hugomed.data.viewmodels.DoctorsViewModel;
import com.apps.client.juan.hugomed.data.viewmodels.OnBoardingViewModel;
import com.apps.client.juan.hugomed.databinding.DoctorsCardOfflineBinding;
import com.apps.client.juan.hugomed.databinding.DoctorsCardOnlineBinding;
import com.apps.client.juan.hugomed.databinding.DoctorslistingBinding;
import com.apps.client.juan.hugomed.helpers.SpannableHelper;

import java.util.Collections;
import java.util.List;

public class DoctorsListing extends AppCompatActivity {
    private DoctorsViewModel viewModel;
    private DoctorslistingBinding doctorsListing;
    private Adapter adapter;
    Runnable runnable;
    public static Doctor selectedDoctor;
    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        doctorsListing = DoctorslistingBinding.inflate(getLayoutInflater());
        setContentView(doctorsListing.getRoot());

        runnable = new Runnable() {
            @Override
            public void run() {
                viewModel.getAllDoctors().observe(DoctorsListing.this, new Observer<List<Doctor>>() {
                    @Override
                    public void onChanged(List<Doctor> doctors) {
                        Collections.sort(doctors, (o1, o2) -> {
                            return o1.availabilityMins - o2.availabilityMins;
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
    }

    public void showDialog(Doctor doctor) {
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

        private List<Doctor> mDoctors;
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
            return mDoctors.get(position).id;
        }

        @Override
        public View getView(int position, View convertView, ViewGroup parent) {
            Doctor doctor = (Doctor)getItem(position);
            doctor.picture = getResources().getDrawable(Integer.parseInt(doctor.photoURL));
            if (doctor.isAvailable) {
                DoctorsCardOnlineBinding binding = DoctorsCardOnlineBinding.inflate(getLayoutInflater(), parent, false);
                binding.setDoctor(mDoctors.get(position));
                binding.setDoctorsListing(DoctorsListing.this);
                return binding.getRoot();
            }
            else {
                DoctorsCardOfflineBinding binding = DoctorsCardOfflineBinding.inflate(getLayoutInflater(), parent, false);
                binding.setDoctor(mDoctors.get(position));
                String str = getResources().getQuantityString(R.plurals.disponsible_en, mDoctors.get(position).availabilityMins, mDoctors.get(position).availabilityMins);
                SpannableString str1 = SpannableHelper.shared.getSpannableString(str.substring(0, str.length()-6), R.style.doctors_card_center_text_offline_attr_1, DoctorsListing.this);
                SpannableString str2 = SpannableHelper.shared.getSpannableString(str.substring(str.length()-6), R.style.doctors_card_center_text_offline_attr_2, DoctorsListing.this);
                SpannedString str3 = (SpannedString) TextUtils.concat(str1, str2);
                binding.centerText.setText(str3, TextView.BufferType.SPANNABLE);
                binding.setDoctorsListing(DoctorsListing.this);
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
