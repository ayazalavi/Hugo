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
import com.apps.client.juan.hugomed.databinding.IncallBinding;

public class InCall extends AppCompatActivity {
    private DoctorsViewModel viewModel;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.incall);

        setSupportActionBar(IncallBinding.inflate(getLayoutInflater()).myToolbar);
        getSupportActionBar().setDisplayShowTitleEnabled(false);
    }

    public void endCall(View view) {
        finish();
        HugoMedDatabase.databaseWriteExecutor.execute(() -> {
            viewModel = new ViewModelProvider(this).get(DoctorsViewModel.class);
            Consultation consultation = viewModel.getRequestedConsultation(StartConsultation.LAST_CONSULTATION_ID);
            consultation.state = ConsulationState.COMPLETED;
            viewModel.updateConsultation(consultation);
        });

        Intent intent = new Intent(this, Receipt.class);
        startActivity(intent);
        overridePendingTransition(R.anim.slide_in_left, R.anim.slide_out_left);
    }
}
