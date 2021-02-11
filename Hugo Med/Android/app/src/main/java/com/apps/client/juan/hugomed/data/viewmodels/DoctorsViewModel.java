package com.apps.client.juan.hugomed.data.viewmodels;

import android.app.Application;

import androidx.lifecycle.AndroidViewModel;
import androidx.lifecycle.LiveData;

import com.apps.client.juan.hugomed.data.entities.ConsulationState;
import com.apps.client.juan.hugomed.data.entities.Consultation;
import com.apps.client.juan.hugomed.data.entities.Doctor;
import com.apps.client.juan.hugomed.data.entities.DoctorWithSpecialities;
import com.apps.client.juan.hugomed.data.helpers.MainRepository;
import com.apps.client.juan.hugomed.data.entities.Receipt;

import java.util.List;

public class DoctorsViewModel extends AndroidViewModel {

    private MainRepository mRepository;

    private LiveData<List<DoctorWithSpecialities>> mAllDoctors;

    private Consultation requestedConsultation;

    public DoctorsViewModel (Application application) {
        super(application);
        mRepository = new MainRepository(application);
        mAllDoctors = mRepository.getAllDoctors();
        requestedConsultation = getLastRequestedConsultation();
    }

    private Consultation getLastRequestedConsultation() {
        List<Consultation> cons = mRepository.getConsultationByState(ConsulationState.REQUESTED);
        if (cons.size() > 0)
            return cons.get(0);
        return null;
    }

    public LiveData<List<DoctorWithSpecialities>> getAllDoctors() { return mAllDoctors; }

    public Consultation getRequestedConsultation(long consulationID) { return mRepository.getConsultation(consulationID); }

    public long insertConsulation(Consultation consultation) { return mRepository.insertConsultation(consultation); }

    public long insertReceipt(Receipt receipt) { return mRepository.insertReceipt(receipt); }

    public long insertDoctor(Doctor doctor) { return mRepository.insertDoctor(doctor); }

    public void updateConsultation(Consultation consultation) { mRepository.updateConsultation(consultation); }

}
