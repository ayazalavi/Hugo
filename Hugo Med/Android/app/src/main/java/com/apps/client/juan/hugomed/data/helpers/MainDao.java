package com.apps.client.juan.hugomed.data.helpers;

import androidx.lifecycle.LiveData;
import androidx.room.Dao;
import androidx.room.Delete;
import androidx.room.Insert;
import androidx.room.OnConflictStrategy;
import androidx.room.Query;
import androidx.room.Transaction;
import androidx.room.Update;

import com.apps.client.juan.hugomed.data.entities.ConsulationState;
import com.apps.client.juan.hugomed.data.entities.Consultation;
import com.apps.client.juan.hugomed.data.entities.Doctor;
import com.apps.client.juan.hugomed.data.entities.DoctorWithConsultations;
import com.apps.client.juan.hugomed.data.entities.FAQ;
import com.apps.client.juan.hugomed.data.entities.Receipt;
import com.apps.client.juan.hugomed.data.entities.ReceiptWithConsultation;

import java.util.List;

@Dao
public interface MainDao {

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    long insertDoctor(Doctor doctor);

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    void insertFAQ(FAQ faq);

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    long insertConsulation(Consultation consulation);

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    long insertReceipt(Receipt receipt);

    @Update
    void updateConsultation(Consultation consulation);

    @Query("SELECT * from Doctor ORDER BY name DESC")
    LiveData<List<Doctor>> getDoctors();

    @Query("SELECT * from Consultation where state = :state")
    List<Consultation> getConsultationsByState(ConsulationState state);

    @Query("SELECT * from Consultation where id = :ID")
    Consultation getConsultationsByID(long ID);

    @Transaction
    @Query("SELECT * from Doctor where id = :docid")
    DoctorWithConsultations getDoctorConsultations(long docid);

    @Query("SELECT * from FAQ ORDER BY id ASC")
    LiveData<List<FAQ>> getFAQs();

    @Transaction
    @Query("SELECT * FROM Consultation")
    List<ReceiptWithConsultation> getAllReceipts();

    @Query("DELETE FROM Doctor")
    void deleteAllDoctors();

    @Query("DELETE FROM FAQ")
    void deleteAllFAQs();

    @Query("DELETE FROM Consultation")
    void deleteAllConsultations();

    @Query("DELETE FROM Receipt")
    void deleteAllReceipts();

}
