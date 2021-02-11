package com.apps.client.juan.hugomed.activities;

import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.content.ServiceConnection;
import android.os.AsyncTask;
import android.os.Bundle;
import android.os.IBinder;
import android.os.Message;
import android.text.SpannableString;
import android.text.SpannedString;
import android.text.TextUtils;
import android.util.DisplayMetrics;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;

import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;
import androidx.databinding.BindingAdapter;

import com.apps.client.juan.hugomed.R;
import com.apps.client.juan.hugomed.data.helpers.General;
import com.apps.client.juan.hugomed.data.helpers.MainRepository;
import com.apps.client.juan.hugomed.databinding.ConsulatationslideupBinding;
import com.apps.client.juan.hugomed.helpers.SpannableHelper;
import com.apps.client.juan.hugomed.service.APIRequest;
import com.apps.client.juan.hugomed.service.MED_API_URL;
import com.google.gson.Gson;

import java.util.Timer;
import java.util.TimerTask;

public class ConsultationSlideup extends AppCompatActivity {
    private ConsulatationslideupBinding consultationBinding;
    private APIRequest mService;
    private boolean mBound;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        consultationBinding = ConsulatationslideupBinding.inflate(getLayoutInflater());
        consultationBinding.setDoctor(DoctorsListing.selectedDoctor);
        String str = getResources().getQuantityString(R.plurals.disponsible_en_popover, (int)DoctorsListing.selectedDoctor.doctor.waiting_time.waiting/60,
                (int)DoctorsListing.selectedDoctor.doctor.waiting_time.waiting/60);
        SpannableString str1 = SpannableHelper.shared.getSpannableString(str, R.style.popover_subtitle_available_in_attr, this);
        consultationBinding.availableIn.setText(str1, TextView.BufferType.SPANNABLE);
        setContentView(consultationBinding.getRoot());
        bindWithService();
      //  General.hide_bottom_nav(this);
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
        if (mBound) {
            unbindService(connection);
        }
    }

    private void bindWithService() {
        try {
            Intent intent = new Intent(this, APIRequest.class);
            MED_API_URL arg = MED_API_URL.GET_DOCTOR_SERVICES;
            arg.param1 = DoctorsListing.selectedDoctor.doctor.id+"";
            intent.putExtra("med_api_url", General.serialize(arg));
            bindService(intent, connection, Context.BIND_AUTO_CREATE);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void lookForData() {
        AsyncTask.execute(new Runnable() {
            @Override
            public void run() {
                try {
                    do {
                        if (!mBound) {
                            break;
                        }
                        Thread.sleep(100);
                    }while(mService.response == null);
                    Log.v("response", mService.response);
                    mService.saveService();
                    runOnUiThread(new Runnable() {
                        @Override
                        public void run() {
                            consultationBinding.setService(APIRequest.current_service);
                        }
                    });
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
            }
        });
    }

    public void closePopover(View view) {
        Intent intent = new Intent(ConsultationSlideup.this, StartConsultation.class);
        startActivity(intent);
        overridePendingTransition(R.anim.slide_in, R.anim.slide_out);
        new Timer().schedule(new TimerTask() {
            @Override
            public void run() {
                finish();
            }
        }, 600);
    }

    private ServiceConnection connection = new ServiceConnection() {

        @Override
        public void onServiceConnected(ComponentName className,
                                       IBinder service) {
            // We've bound to LocalService, cast the IBinder and get LocalService instance
            APIRequest.LocalBinder binder = (APIRequest.LocalBinder) service;
            mService = binder.getService();
            mBound = true;
            lookForData();
            Log.v("service connected", "true");
        }

        @Override
        public void onServiceDisconnected(ComponentName arg0) {
            mBound = false;
        }
    };
}