package com.apps.client.juan.hugomed.data.viewmodels;

import android.app.Application;

import androidx.lifecycle.AndroidViewModel;
import androidx.lifecycle.LiveData;

import com.apps.client.juan.hugomed.data.entities.ConsulationState;
import com.apps.client.juan.hugomed.data.entities.Consultation;
import com.apps.client.juan.hugomed.data.entities.Doctor;
import com.apps.client.juan.hugomed.data.entities.FAQ;
import com.apps.client.juan.hugomed.data.entities.Receipt;
import com.apps.client.juan.hugomed.data.helpers.MainRepository;

import java.util.List;

public class FAQViewModel extends AndroidViewModel {

    private MainRepository mRepository;

    private LiveData<List<FAQ>> mAllFAQs;

    private Consultation requestedConsultation;

    public FAQViewModel(Application application) {
        super(application);
        mRepository = new MainRepository(application);
        mAllFAQs = mRepository.getALLFAQs();
    }

    public LiveData<List<FAQ>> getALLFAQs() { return mAllFAQs; }

}
