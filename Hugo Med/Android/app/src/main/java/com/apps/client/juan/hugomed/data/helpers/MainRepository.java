package com.apps.client.juan.hugomed.data.helpers;

import android.app.Application;

import androidx.appcompat.widget.AppCompatTextView;
import androidx.lifecycle.LiveData;

import com.apps.client.juan.hugomed.data.entities.Company;
import com.apps.client.juan.hugomed.data.entities.ConsulationState;
import com.apps.client.juan.hugomed.data.entities.Consultation;
import com.apps.client.juan.hugomed.data.entities.Doctor;
import com.apps.client.juan.hugomed.data.entities.DoctorWithSpecialities;
import com.apps.client.juan.hugomed.data.entities.FAQ;
import com.apps.client.juan.hugomed.data.entities.Patient;
import com.apps.client.juan.hugomed.data.entities.Receipt;
import com.apps.client.juan.hugomed.data.entities.ReceiptWithConsultation;
import com.apps.client.juan.hugomed.data.entities.Speciality;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class MainRepository {

    private final LiveData<List<FAQ>> mAllFAQs;
    private MainDao mMainDao;
    private LiveData<List<DoctorWithSpecialities>> mAllDoctors;
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

    public LiveData<List<DoctorWithSpecialities>> getAllDoctors() {
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

    public List<DoctorWithSpecialities> insertOnDemandDoctors(Doctor... doctors) {
        ArrayList<Speciality> specialities = new ArrayList<Speciality>();
        for (Doctor doctor: doctors) {
            if (doctor.on_demand) {
                long id = mMainDao.insertDoctor(doctor);
                for (Speciality speciality: doctor.specialties) {
                    speciality.doctorID = id;
                    specialities.add(speciality);
                }
            }
        }
        mMainDao.insertSpecialities(specialities.toArray(new Speciality[0]));
        return mMainDao.getDoctorsWithSpecialities();
    }

    public long insertReceipt(Receipt receipt) {
        return mMainDao.insertReceipt(receipt);
    }

    public long insertPatient(Patient patient) {
        return mMainDao.insertPatient(patient);
    }

    public List<Company> insertCompanies(Company[] companies) {
        mMainDao.insertCompanies(companies);
        return mMainDao.getCompanies("Microuniverse");
    }

    public void updateConsultation(Consultation consultation) {
        mMainDao.updateConsultation(consultation);
    }
}