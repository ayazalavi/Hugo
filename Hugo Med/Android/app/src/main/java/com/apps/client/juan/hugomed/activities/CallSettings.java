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
import com.apps.client.juan.hugomed.data.entities.Receipt;
import com.apps.client.juan.hugomed.data.helpers.HugoMedDatabase;
import com.apps.client.juan.hugomed.data.viewmodels.DoctorsViewModel;
import com.apps.client.juan.hugomed.databinding.CallsettingsBinding;
import com.apps.client.juan.hugomed.databinding.IncallBinding;

import java.util.Date;

public class CallSettings extends AppCompatActivity {
    private DoctorsViewModel viewModel;
    private CallsettingsBinding callSettings;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        callSettings = CallsettingsBinding.inflate(getLayoutInflater());
        setContentView(callSettings.getRoot());

        HugoMedDatabase.databaseWriteExecutor.execute(() -> {
            viewModel = new ViewModelProvider(this).get(DoctorsViewModel.class);
            Consultation consultation = viewModel.getRequestedConsultation(StartConsultation.LAST_CONSULTATION_ID);
            consultation.state = ConsulationState.IN_PROGRESS;
            viewModel.updateConsultation(consultation);
            viewModel.insertReceipt(new Receipt("HPY-SOL-"+consultation.id, "hugoMed", consultation.id));
        });

        setSupportActionBar(callSettings.myToolbar);
        getSupportActionBar().setDisplayShowTitleEnabled(false);
        callSettings.myToolbar.setNavigationOnClickListener(v -> {
            finish();
        });
    }

    public void startCall(View view) {
        finish();
        Intent intent = new Intent(this, InCall.class);
        startActivity(intent);
        overridePendingTransition(R.anim.slide_in_left, R.anim.slide_out_left);
    }
}
