package com.apps.client.juan.hugomed.data.helpers;

import android.app.Application;

import androidx.appcompat.widget.AppCompatTextView;
import androidx.lifecycle.LiveData;

import com.apps.client.juan.hugomed.data.entities.ConsulationState;
import com.apps.client.juan.hugomed.data.entities.Consultation;
import com.apps.client.juan.hugomed.data.entities.Doctor;
import com.apps.client.juan.hugomed.data.entities.FAQ;
import com.apps.client.juan.hugomed.data.entities.Receipt;
import com.apps.client.juan.hugomed.data.entities.ReceiptWithConsultation;

import java.util.ArrayList;
import java.util.List;

public class MainRepository {

    private final LiveData<List<FAQ>> mAllFAQs;
    private MainDao mMainDao;
    private LiveData<List<Doctor>> mAllDoctors;
    private List<Consultation> mRequestedConsulations;
    private List<ReceiptWithConsultation> mReceipts;

    public MainRepository(Application application) {
        HugoMedDatabase db = HugoMedDatabase.getDatabase(application);
        mMainDao = db.mainDao();
        mAllDoctors = mMainDao.getDoctors();
        mAllFAQs = mMainDao.getFAQs();
        mRequestedConsulations = mMainDao.getConsultationsByState(ConsulationState.REQUESTED);
        mReceipts = mMainDao.getAllReceipts();
    }

    public LiveData<List<Doctor>> getAllDoctors() {
        return mAllDoctors;
    }

    public LiveData<List<FAQ>> getALLFAQs() {
        return mAllFAQs;
    }

    public ReceiptWithConsultation getReceipt(long consultationID) {
        if (mReceipts.size() > 0) {
            for (ReceiptWithConsultation receipt: mReceipts) {
                if (receipt.consultation.id == consultationID) {
                    return receipt;
                }
            }
        }
        return null;
    }

    public Doctor getDoctorBytheConsultation(Consultation consultation) {
        return mMainDao.getDoctorConsultations(consultation.doctorID).doctor;
    }

    public List<Consultation> getConsultationByState(ConsulationState state) {
        List<Consultation> consulations = new ArrayList<Consultation>();
        if (mRequestedConsulations.size() > 0) {
            for(Consultation consulation: mRequestedConsulations) {
                if (consulation.state == state) {
                    consulations.add(consulation);
                }
            }
        }
        return consulations;
    }

    public Consultation getConsultation(long consultationID) {
        return mMainDao.getConsultationsByID(consultationID);
    }

    public long insertConsultation(Consultation consultation) {
        return mMainDao.insertConsulation(consultation);
    }

    public long insertDoctor(Doctor doctor) {
        return mMainDao.insertDoctor(doctor);
    }

    public long insertReceipt(Receipt receipt) {
        return mMainDao.insertReceipt(receipt);
    }

    public void updateConsultation(Consultation consultation) {
        mMainDao.updateConsultation(consultation);
    }
}