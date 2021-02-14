package com.apps.client.juan.hugomed.activities;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;

import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;
import androidx.lifecycle.ViewModelProvider;

import com.apps.client.juan.hugomed.R;
import com.apps.client.juan.hugomed.data.entities.ConsulationState;
import com.apps.client.juan.hugomed.data.entities.Consultation;
import com.apps.client.juan.hugomed.data.helpers.HugoMedDatabase;
import com.apps.client.juan.hugomed.data.viewmodels.DoctorsViewModel;
import com.apps.client.juan.hugomed.databinding.StartconsultationBinding;

import java.util.Date;
import java.util.Timer;
import java.util.TimerTask;

public class StartConsultation extends AppCompatActivity {
    private DoctorsViewModel viewModel;

    public static long LAST_CONSULTATION_ID;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.startconsultation);

        setSupportActionBar(StartconsultationBinding.inflate(getLayoutInflater()).myToolbar);
    }

    public void cancel(View view) {
        finish();
    }

    public void startConsulatation(View view) {

        HugoMedDatabase.databaseWriteExecutor.execute(() -> {
            viewModel = new ViewModelProvider(this).get(DoctorsViewModel.class);
            LAST_CONSULTATION_ID = viewModel.insertConsulation(new Consultation(DoctorsListing.selectedDoctor.id, new Date(), new Date(), ConsulationState.REQUESTED));
        });
        finish();
        if (DoctorsListing.selectedDoctor.isAvailable) {
            Intent intent = new Intent(this, CallSettings.class);
            startActivity(intent);
            overridePendingTransition(R.anim.slide_in_left, R.anim.slide_out_left);
        }
        else {

            new Timer().schedule(new TimerTask() {
                @Override
                public void run() {
                    Intent intent = new Intent(StartConsultation.this, NotifyPopover.class);
                    startActivity(intent);
                    overridePendingTransition(R.anim.fade_in, R.anim.fade_out);
                }
            }, 1000);
        }
    }
}