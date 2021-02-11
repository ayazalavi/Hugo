package com.apps.client.juan.hugomed.activities;

import android.content.Intent;
import android.os.Bundle;

import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;
import androidx.lifecycle.Observer;
import androidx.lifecycle.ViewModelProvider;

import com.apps.client.juan.hugomed.R;
import com.apps.client.juan.hugomed.data.entities.Doctor;
import com.apps.client.juan.hugomed.data.entities.ReceiptWithConsultation;
import com.apps.client.juan.hugomed.data.helpers.General;
import com.apps.client.juan.hugomed.data.helpers.HugoMedDatabase;
import com.apps.client.juan.hugomed.data.viewmodels.DoctorsViewModel;
import com.apps.client.juan.hugomed.data.viewmodels.ReceiptViewModel;
import com.apps.client.juan.hugomed.databinding.CallsettingsBinding;
import com.apps.client.juan.hugomed.databinding.ReceiptBinding;
import com.apps.client.juan.hugomed.service.APIRequest;

import java.util.Collections;
import java.util.List;

public class Receipt extends AppCompatActivity {
    private ReceiptBinding receiptBinding;
    private Runnable runnable;
    private ReceiptViewModel viewModel;
    private ReceiptWithConsultation receipt;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        receiptBinding = ReceiptBinding.inflate(getLayoutInflater());
        receiptBinding.setAppointment(APIRequest.current_appointment);
        receiptBinding.setService(APIRequest.current_service);
        setContentView(receiptBinding.getRoot());
        //receiptBinding.setDoctor(DoctorsListing.selectedDoctor);
        General.hide_bottom_nav(this);
        setSupportActionBar(receiptBinding.myToolbar);
        getSupportActionBar().setDisplayShowTitleEnabled(false);
        receiptBinding.myToolbar.setNavigationOnClickListener(v -> {
            APIRequest.current_appointment = null;
            Intent intent = new Intent(Receipt.this, DoctorsListing.class);
            intent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
            startActivity(intent);
        });
    }
}
