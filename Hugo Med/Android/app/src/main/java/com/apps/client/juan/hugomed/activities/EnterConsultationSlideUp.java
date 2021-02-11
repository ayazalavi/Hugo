package com.apps.client.juan.hugomed.activities;

import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.content.ServiceConnection;
import android.os.AsyncTask;
import android.os.Bundle;
import android.os.IBinder;
import android.text.SpannableString;
import android.util.Log;
import android.view.View;
import android.widget.TextView;

import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;
import androidx.lifecycle.ViewModelProvider;

import com.apps.client.juan.hugomed.R;
import com.apps.client.juan.hugomed.data.entities.ConsulationState;
import com.apps.client.juan.hugomed.data.entities.Consultation;
import com.apps.client.juan.hugomed.data.helpers.General;
import com.apps.client.juan.hugomed.data.helpers.HugoMedDatabase;
import com.apps.client.juan.hugomed.data.viewmodels.DoctorsViewModel;
import com.apps.client.juan.hugomed.databinding.ConsulatationslideupBinding;
import com.apps.client.juan.hugomed.databinding.EnterconsultationslideupBinding;
import com.apps.client.juan.hugomed.helpers.SpannableHelper;
import com.apps.client.juan.hugomed.service.APIRequest;
import com.apps.client.juan.hugomed.service.APIUrl;
import com.apps.client.juan.hugomed.service.MED_API_URL;

import java.io.IOException;
import java.util.Timer;
import java.util.TimerTask;

public class EnterConsultationSlideUp extends AppCompatActivity {
    private EnterconsultationslideupBinding consultationBinding;
    private DoctorsViewModel viewModel;
    private Runnable runnable;
    private APIRequest mService;
    private boolean mBound = false;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        consultationBinding = EnterconsultationslideupBinding.inflate(getLayoutInflater());
        consultationBinding.setDoctor(DoctorsListing.selectedDoctor);
        setContentView(consultationBinding.getRoot());

        if (DoctorsListing.selectedDoctor.doctor.waiting_time.waiting != 0) {
            bindWithService();
            runnable = new Runnable() {
                @Override
                public void run() {
                    Intent intent = new Intent(EnterConsultationSlideUp.this, EnterConsultationSlideUp.class);
                    startActivity(intent);
                    overridePendingTransition(R.anim.slide_in, R.anim.slide_out);
                }
            };
            AsyncTask.execute(new Runnable() {
                @Override
                public void run() {
                    Timer timer = new Timer();
                    timer.schedule(new TimerTask() {
                        @Override
                        public void run() {
                            if (DoctorsListing.selectedDoctor.doctor != null && DoctorsListing.selectedDoctor.doctor.waiting_time.waiting == 0) {
                                runOnUiThread(runnable);
                                timer.cancel();
                            }
                        }
                    }, 0, 5000);
                }
            });
        }
    }

    @Override
    protected void onStart() {
        super.onStart();
        General.hide_bottom_nav(this);
    }

    @Override
    protected void onNewIntent(Intent intent) {
        super.onNewIntent(intent);
        if (consultationBinding != null) {
            consultationBinding.setDoctor(DoctorsListing.selectedDoctor);
        }
    }

    private void bindWithService() {
        try {
            Intent intent = new Intent(this, APIRequest.class);
            bindService(intent, connection, Context.BIND_AUTO_CREATE);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
        if(mBound) {
            unbindService(connection);
        }
    }

    private void registerAppointment() {
        AsyncTask.execute(new Runnable() {
            @Override
            public void run() {
                try {
                    mService.make_an_appointment(APIUrl.url(MED_API_URL.REGISTER_ON_DEMAND_APPOINTMENT));
                    Log.v("appointment", mService.response);
                    if (APIRequest.current_appointment != null && APIRequest.current_comm_keys != null) {
                        Log.v("video-token", APIRequest.current_comm_keys.videotoken);
                        Log.v("session", APIRequest.current_comm_keys.session);
                        Log.v("api", APIRequest.current_comm_keys.api);
                        runOnUiThread(new Runnable() {
                            @Override
                            public void run() {
                                Intent intent = new Intent(EnterConsultationSlideUp.this, CallSettings.class);
                                startActivity(intent);
                                overridePendingTransition(R.anim.slide_in, R.anim.slide_out);
                                new Timer().schedule(new TimerTask() {
                                    @Override
                                    public void run() {
                                        finish();
                                    }
                                }, 600);
                                //consultationBinding.setService(APIRequest.current_service);
                            }
                        });
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        });
    }

    public void enterConsultation(View view) {
        if (APIRequest.current_appointment == null) {
        registerAppointment();
        }
        else {
            Intent intent = new Intent(EnterConsultationSlideUp.this, CallSettings.class);
            startActivity(intent);
            overridePendingTransition(R.anim.slide_in, R.anim.slide_out);
            new Timer().schedule(new TimerTask() {
                @Override
                public void run() {
                    finish();
                }
            }, 600);
        }
    }

    private ServiceConnection connection = new ServiceConnection() {

        @Override
        public void onServiceConnected(ComponentName className,
                                       IBinder service) {
            // We've bound to LocalService, cast the IBinder and get LocalService instance
            APIRequest.LocalBinder binder = (APIRequest.LocalBinder) service;
            mService = binder.getService();
            mBound = true;
            try {
                Intent intent = new Intent(EnterConsultationSlideUp.this, APIRequest.class);
                MED_API_URL arg = MED_API_URL.GET_DOCTOR_BY_ID;
                arg.param1 = DoctorsListing.selectedDoctor.doctor.id+"";
                intent.putExtra("med_api_url", General.serialize(arg));
                mService.requestData(intent);
            } catch (IOException e) {
                e.printStackTrace();
            }
            Log.v("service connected", "true");
        }

        @Override
        public void onServiceDisconnected(ComponentName arg0) {
            mBound = false;
        }
    };
}