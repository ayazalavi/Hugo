package com.apps.client.juan.hugomed.data.helpers;

import androidx.lifecycle.LiveData;
import androidx.room.Dao;
import androidx.room.Delete;
import androidx.room.Insert;
import androidx.room.OnConflictStrategy;
import androidx.room.Query;
import androidx.room.Transaction;
import androidx.room.Update;

import com.apps.client.juan.hugomed.data.entities.Company;
import com.apps.client.juan.hugomed.data.entities.ConsulationState;
import com.apps.client.juan.hugomed.data.entities.Consultation;
import com.apps.client.juan.hugomed.data.entities.Doctor;
import com.apps.client.juan.hugomed.data.entities.DoctorWithConsultations;
import com.apps.client.juan.hugomed.data.entities.DoctorWithSpecialities;
import com.apps.client.juan.hugomed.data.entities.FAQ;
import com.apps.client.juan.hugomed.data.entities.Patient;
import com.apps.client.juan.hugomed.data.entities.Receipt;
import com.apps.client.juan.hugomed.data.entities.ReceiptWithConsultation;
import com.apps.client.juan.hugomed.data.entities.Speciality;

import java.util.List;

@Dao
public interface MainDao {

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    long insertDoctor(Doctor doctor);

    @Transaction
    @Insert(onConflict = OnConflictStrategy.REPLACE)
    void insertDoctors(Doctor... doctors);

    @Transaction
    @Insert(onConflict = OnConflictStrategy.REPLACE)
    void insertSpecialities(Speciality... specialities);

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    void insertFAQ(FAQ faq);

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    long insertConsulation(Consultation consulation);

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    long insertReceipt(Receipt receipt);

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    long insertPatient(Patient patient);

    @Transaction
    @Insert(onConflict = OnConflictStrategy.REPLACE)
    void insertCompanies(Company... companies);

    @Update
    void updateConsultation(Consultation consulation);

    @Transaction
    @Query("SELECT * from Doctor")
    public LiveData<List<DoctorWithSpecialities>> getDoctors();

    @Transaction
    @Query("SELECT * from Doctor")
    public List<DoctorWithSpecialities> getDoctorsWithSpecialities();

    @Query("SELECT * from Consultation where state = :state")
    List<Consultation> getConsultationsByState(ConsulationState state);

    @Query("SELECT * from Consultation where id = :ID")
    Consultation getConsultationsByID(long ID);

    @Transaction
    @Query("SELECT * from Doctor where doctorID = :docid")
    DoctorWithConsultations getDoctorConsultations(long docid);

    @Query("SELECT * from FAQ ORDER BY id ASC")
    LiveData<List<FAQ>> getFAQs();

    @Transaction
    @Query("SELECT * FROM Consultation")
    List<ReceiptWithConsultation> getAllReceipts();

    @Query("SELECT * from Company where tag_name=:name")
    List<Company> getCompanies(String name);

    @Query("DELETE FROM Doctor")
    void deleteAllDoctors();

    @Query("DELETE FROM FAQ")
    void deleteAllFAQs();

    @Query("DELETE FROM Consultation")
    void deleteAllConsultations();

    @Query("DELETE FROM Receipt")
    void deleteAllReceipts();

}
