package com.apps.client.juan.hugomed.activities;

import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.content.ServiceConnection;
import android.os.AsyncTask;
import android.os.Bundle;
import android.os.IBinder;
import android.util.Log;
import android.view.View;

import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;
import androidx.lifecycle.ViewModelProvider;

import com.apps.client.juan.hugomed.R;
import com.apps.client.juan.hugomed.data.entities.ConsulationState;
import com.apps.client.juan.hugomed.data.entities.Consultation;
import com.apps.client.juan.hugomed.data.helpers.General;
import com.apps.client.juan.hugomed.data.helpers.HugoMedDatabase;
import com.apps.client.juan.hugomed.data.viewmodels.DoctorsViewModel;
import com.apps.client.juan.hugomed.databinding.StartconsultationBinding;
import com.apps.client.juan.hugomed.service.APIRequest;
import com.apps.client.juan.hugomed.service.APIUrl;
import com.apps.client.juan.hugomed.service.MED_API_URL;

import java.util.Date;
import java.util.Timer;
import java.util.TimerTask;

public class StartConsultation extends AppCompatActivity {
    private DoctorsViewModel viewModel;
    private APIRequest mService;
    private boolean mBound = false;
    public static long LAST_CONSULTATION_ID;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.startconsultation);
        setSupportActionBar(StartconsultationBinding.inflate(getLayoutInflater()).myToolbar);
        bindWithService();
        General.hide_bottom_nav(this);
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
        if(mBound) {
            unbindService(connection);
        }
    }

    private void bindWithService() {
        try {
            Intent intent = new Intent(this, APIRequest.class);
            MED_API_URL arg = MED_API_URL.REGISTER_ON_DEMAND_APPOINTMENT;
            intent.putExtra("med_api_url", General.serialize(arg));
            bindService(intent, connection, Context.BIND_AUTO_CREATE);
        } catch (Exception e) {
            e.printStackTrace();
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
                                Intent intent = new Intent(StartConsultation.this, CallSettings.class);
                                startActivity(intent);
                                overridePendingTransition(R.anim.slide_in_left, R.anim.slide_out_left);
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

    public void cancel(View view) {
        finish();
    }

    public void startConsulatation(View view) {

        if (DoctorsListing.selectedDoctor.doctor.waiting_time.waiting == 0) {
            registerAppointment();
        }
        else {
            finish();
            new Timer().schedule(new TimerTask() {
                @Override
                public void run() {
                    Intent intent = new Intent(StartConsultation.this, NotifyPopover.class);
                    startActivity(intent);
                    overridePendingTransition(R.anim.slide_in, R.anim.slide_out);
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
            Log.v("service connected", "true");
        }

        @Override
        public void onServiceDisconnected(ComponentName arg0) {
            mBound = false;
        }
    };
}