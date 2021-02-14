package com.apps.client.juan.hugomed.activities;

import android.os.Bundle;

import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;
import androidx.lifecycle.Observer;
import androidx.lifecycle.ViewModelProvider;

import com.apps.client.juan.hugomed.R;
import com.apps.client.juan.hugomed.data.entities.Doctor;
import com.apps.client.juan.hugomed.data.entities.ReceiptWithConsultation;
import com.apps.client.juan.hugomed.data.helpers.HugoMedDatabase;
import com.apps.client.juan.hugomed.data.viewmodels.DoctorsViewModel;
import com.apps.client.juan.hugomed.data.viewmodels.ReceiptViewModel;
import com.apps.client.juan.hugomed.databinding.CallsettingsBinding;
import com.apps.client.juan.hugomed.databinding.ReceiptBinding;

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
        receiptBinding.setDoctor(DoctorsListing.selectedDoctor);
        runnable = new Runnable() {
            @Override
            public void run() {
                receiptBinding.setData(receipt);
                setContentView(receiptBinding.getRoot());
            }
        };
        HugoMedDatabase.databaseWriteExecutor.execute(() -> {
            viewModel = new ViewModelProvider(this).get(ReceiptViewModel.class);
            receipt = viewModel.getReceipt(StartConsultation.LAST_CONSULTATION_ID);
            runOnUiThread(runnable);
        });

        setSupportActionBar(receiptBinding.myToolbar);
        getSupportActionBar().setDisplayShowTitleEnabled(false);
        receiptBinding.myToolbar.setNavigationOnClickListener(v -> {
            finish();
        });
    }
}
