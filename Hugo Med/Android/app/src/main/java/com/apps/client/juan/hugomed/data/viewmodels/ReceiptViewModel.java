package com.apps.client.juan.hugomed.data.viewmodels;

import android.app.Application;

import androidx.lifecycle.AndroidViewModel;
import androidx.lifecycle.LiveData;

import com.apps.client.juan.hugomed.data.entities.ConsulationState;
import com.apps.client.juan.hugomed.data.entities.Consultation;
import com.apps.client.juan.hugomed.data.entities.Doctor;
import com.apps.client.juan.hugomed.data.entities.ReceiptWithConsultation;
import com.apps.client.juan.hugomed.data.helpers.MainRepository;

import java.util.List;

public class ReceiptViewModel extends AndroidViewModel {

    private MainRepository mRepository;

    public ReceiptViewModel(Application application) {
        super(application);
        mRepository = new MainRepository(application);
    }

    public ReceiptWithConsultation getReceipt(long consultationID) { return mRepository.getReceipt(consultationID); }


}
