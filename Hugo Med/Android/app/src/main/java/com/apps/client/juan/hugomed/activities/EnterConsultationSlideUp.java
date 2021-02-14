package com.apps.client.juan.hugomed.activities;

import android.content.Intent;
import android.os.Bundle;
import android.text.SpannableString;
import android.view.View;
import android.widget.TextView;

import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;
import androidx.lifecycle.ViewModelProvider;

import com.apps.client.juan.hugomed.R;
import com.apps.client.juan.hugomed.data.entities.ConsulationState;
import com.apps.client.juan.hugomed.data.entities.Consultation;
import com.apps.client.juan.hugomed.data.helpers.HugoMedDatabase;
import com.apps.client.juan.hugomed.data.viewmodels.DoctorsViewModel;
import com.apps.client.juan.hugomed.databinding.ConsulatationslideupBinding;
import com.apps.client.juan.hugomed.databinding.EnterconsultationslideupBinding;
import com.apps.client.juan.hugomed.helpers.SpannableHelper;

import java.util.Timer;
import java.util.TimerTask;

public class EnterConsultationSlideUp extends AppCompatActivity {
    private EnterconsultationslideupBinding consultationBinding;
    private DoctorsViewModel viewModel;
    private Runnable runnable;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        consultationBinding = EnterconsultationslideupBinding.inflate(getLayoutInflater());
        consultationBinding.setDoctor(DoctorsListing.selectedDoctor);
        setContentView(consultationBinding.getRoot());

        runnable = new Runnable() {
            @Override
            public void run() {
                finish();
                Intent intent = new Intent(EnterConsultationSlideUp.this, EnterConsultationSlideUp.class);
                startActivity(intent);
                overridePendingTransition(R.anim.slide_in, R.anim.slide_out);
            }
        };
        if (!DoctorsListing.selectedDoctor.isAvailable) {
            new Timer().schedule(new TimerTask() {
                @Override
                public void run() {
                    HugoMedDatabase.databaseWriteExecutor.execute(() -> {
                        viewModel = new ViewModelProvider(EnterConsultationSlideUp.this).get(DoctorsViewModel.class);
                        DoctorsListing.selectedDoctor.setAvailable();
                        viewModel.insertDoctor(DoctorsListing.selectedDoctor);
                        runOnUiThread(runnable);
                    });
                }
            }, 3000);
        }
    }

    public void enterConsultation(View view) {
        finish();
        new Timer().schedule(new TimerTask() {
            @Override
            public void run() {
                Intent intent = new Intent(EnterConsultationSlideUp.this, CallSettings.class);
                startActivity(intent);
                overridePendingTransition(R.anim.slide_in_left, R.anim.slide_out_left);
            }
        }, 1000);

    }
}