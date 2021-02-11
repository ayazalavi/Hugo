package com.apps.client.juan.hugomed.data.helpers;

import android.content.Context;

import androidx.annotation.NonNull;
import androidx.room.Database;
import androidx.room.Room;
import androidx.room.RoomDatabase;
import androidx.room.TypeConverters;
import androidx.room.migration.Migration;
import androidx.sqlite.db.SupportSQLiteDatabase;

import com.apps.client.juan.hugomed.R;
import com.apps.client.juan.hugomed.data.entities.Appointment;
import com.apps.client.juan.hugomed.data.entities.Company;
import com.apps.client.juan.hugomed.data.entities.ConsulationState;
import com.apps.client.juan.hugomed.data.entities.Consultation;
import com.apps.client.juan.hugomed.data.entities.Currency;
import com.apps.client.juan.hugomed.data.entities.Doctor;
import com.apps.client.juan.hugomed.data.entities.DoctorSpecialities;
import com.apps.client.juan.hugomed.data.entities.FAQ;
import com.apps.client.juan.hugomed.data.entities.Patient;
import com.apps.client.juan.hugomed.data.entities.Receipt;
import com.apps.client.juan.hugomed.data.entities.Service;
import com.apps.client.juan.hugomed.data.entities.Speciality;

import java.util.Date;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

@Database(entities = {Appointment.class, Company.class, Doctor.class, DoctorSpecialities.class,
        Patient.class, FAQ.class, Service.class, Receipt.class, Speciality.class, Consultation.class}, version = 6, exportSchema = false)
@TypeConverters({Converters.class})
public abstract class HugoMedDatabase extends RoomDatabase {

    public abstract MainDao mainDao();

    private static volatile HugoMedDatabase INSTANCE;
    private static final int NUMBER_OF_THREADS = 4;
    public static final ExecutorService databaseWriteExecutor =
            Executors.newFixedThreadPool(NUMBER_OF_THREADS);
    public Context mContext; 

    public static HugoMedDatabase getDatabase(final Context context) {
        if (INSTANCE == null) {
            synchronized (HugoMedDatabase.class) {
                if (INSTANCE == null) {
                    INSTANCE = Room.databaseBuilder(context.getApplicationContext(),
                            HugoMedDatabase.class, "db").addCallback(sRoomDatabaseCallback).fallbackToDestructiveMigration()
                            .build();
                    INSTANCE.mContext = context;
                }
            }
        }
        return INSTANCE;
    }

    static final Migration MIGRATION_1_2 = new Migration(1, 2) {
        @Override
        public void migrate(SupportSQLiteDatabase database) {
            database.execSQL("DROP TABLE Doctor");
        }
    };

    private static RoomDatabase.Callback sRoomDatabaseCallback = new RoomDatabase.Callback() {
        @Override
        public void onOpen(@NonNull SupportSQLiteDatabase db) {
            super.onOpen(db);

            // If you want to keep data through app restarts,
            // comment out the following block
            databaseWriteExecutor.execute(() -> {
                // Populate the database in the background.
                // If you want to start with more words, just add them.
                MainDao dao = INSTANCE.mainDao();
                dao.deleteAllDoctors();
                dao.deleteAllFAQs();
                dao.deleteAllConsultations();
                dao.deleteAllReceipts();
                int i=1;
                /*Doctor doc = new Doctor(i++, "" + R.drawable.doctors_listing_photo, "Carmen Beltrán", "Médico general", true, 0, 8);
                doc.picture = INSTANCE.mContext.getResources().getDrawable(R.drawable.doctors_listing_photo);
                dao.insertDoctor(doc);
                Doctor doc1 = new Doctor(i++,"" + R.drawable.doctors_listing_photo,"Alfonso Beltrán", "Médico general", true, 0, 15);
                doc1.picture = INSTANCE.mContext.getResources().getDrawable(R.drawable.doctors_listing_photo);
                dao.insertDoctor(doc1);
                Doctor doc2 = new Doctor(i++,"" + R.drawable.doctors_listing_photo,"Alejandro Artiga", "Médico general", true, 0, 25);
                doc2.picture = INSTANCE.mContext.getResources().getDrawable(R.drawable.doctors_listing_photo);
                dao.insertDoctor(doc2);
                Doctor doc3 = new Doctor(i++,"" + R.drawable.doctors_listing_photo,"Lissette Flores", "Médico general", false, 5, 30);
                doc3.picture = INSTANCE.mContext.getResources().getDrawable(R.drawable.doctors_listing_photo);
                dao.insertDoctor(doc3);
                Doctor doc4 = new Doctor(i++,"" + R.drawable.doctors_listing_photo,"Ernesto Perez", "Médico general", false, 6, 1000);
                doc4.picture = INSTANCE.mContext.getResources().getDrawable(R.drawable.doctors_listing_photo);
                dao.insertDoctor(doc4);
                Doctor doc5 = new Doctor(i++,"" + R.drawable.doctors_listing_photo,"Eugenia Landaverde", "Médico general", false, 10, 100);
                doc5.picture = INSTANCE.mContext.getResources().getDrawable(R.drawable.doctors_listing_photo);
                dao.insertDoctor(doc5);
                Doctor doc6 = new Doctor(i++,"" + R.drawable.doctors_listing_photo,"Eugenia Flores", "Médico general", false, 2, 8);
                doc6.picture = INSTANCE.mContext.getResources().getDrawable(R.drawable.doctors_listing_photo);
                dao.insertDoctor(doc6);*/

                i=1;
                FAQ faq = new FAQ(i++, i+" Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam sed ligula nulla?", "Sed aliquam nec diam eu ultricies. Curabitur mollis sollicitudin lacus, sed aliquet nisi molestie a. Aenean quis consectetur est, nec luctus risus. Etiam fringilla feugiat metus, tincidunt aliquam sapien malesuada vel. Nulla at ultricies ante, sed mattis ipsum. Fusce dignissim maximus massa id aliquet. ");
                dao.insertFAQ(faq);
                faq = new FAQ(i++, i+" Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam sed ligula nulla?", "Sed aliquam nec diam eu ultricies. Curabitur mollis sollicitudin lacus, sed aliquet nisi molestie a. Aenean quis consectetur est, nec luctus risus. Etiam fringilla feugiat metus, tincidunt aliquam sapien malesuada vel. Nulla at ultricies ante, sed mattis ipsum. Fusce dignissim maximus massa id aliquet. ");
                dao.insertFAQ(faq);
                faq = new FAQ(i++, i+" Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam sed ligula nulla?", "Sed aliquam nec diam eu ultricies. Curabitur mollis sollicitudin lacus, sed aliquet nisi molestie a. Aenean quis consectetur est, nec luctus risus. Etiam fringilla feugiat metus, tincidunt aliquam sapien malesuada vel. Nulla at ultricies ante, sed mattis ipsum. Fusce dignissim maximus massa id aliquet. ");
                dao.insertFAQ(faq);
                faq = new FAQ(i++, i+" Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam sed ligula nulla?", "Sed aliquam nec diam eu ultricies. Curabitur mollis sollicitudin lacus, sed aliquet nisi molestie a. Aenean quis consectetur est, nec luctus risus. Etiam fringilla feugiat metus, tincidunt aliquam sapien malesuada vel. Nulla at ultricies ante, sed mattis ipsum. Fusce dignissim maximus massa id aliquet. ");
                dao.insertFAQ(faq);
                faq = new FAQ(i++, i+" Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam sed ligula nulla?", "Sed aliquam nec diam eu ultricies. Curabitur mollis sollicitudin lacus, sed aliquet nisi molestie a. Aenean quis consectetur est, nec luctus risus. Etiam fringilla feugiat metus, tincidunt aliquam sapien malesuada vel. Nulla at ultricies ante, sed mattis ipsum. Fusce dignissim maximus massa id aliquet. ");
                dao.insertFAQ(faq);
                faq = new FAQ(i++, i+" Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam sed ligula nulla?", "Sed aliquam nec diam eu ultricies. Curabitur mollis sollicitudin lacus, sed aliquet nisi molestie a. Aenean quis consectetur est, nec luctus risus. Etiam fringilla feugiat metus, tincidunt aliquam sapien malesuada vel. Nulla at ultricies ante, sed mattis ipsum. Fusce dignissim maximus massa id aliquet. ");
                dao.insertFAQ(faq);
                faq = new FAQ(i++, i+" Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam sed ligula nulla?", "Sed aliquam nec diam eu ultricies. Curabitur mollis sollicitudin lacus, sed aliquet nisi molestie a. Aenean quis consectetur est, nec luctus risus. Etiam fringilla feugiat metus, tincidunt aliquam sapien malesuada vel. Nulla at ultricies ante, sed mattis ipsum. Fusce dignissim maximus massa id aliquet. ");
                dao.insertFAQ(faq);
                faq = new FAQ(i++, i+" Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam sed ligula nulla?", "Sed aliquam nec diam eu ultricies. Curabitur mollis sollicitudin lacus, sed aliquet nisi molestie a. Aenean quis consectetur est, nec luctus risus. Etiam fringilla feugiat metus, tincidunt aliquam sapien malesuada vel. Nulla at ultricies ante, sed mattis ipsum. Fusce dignissim maximus massa id aliquet. ");
                dao.insertFAQ(faq);


                Consultation consultation = new Consultation(3, new Date(), new Date(), ConsulationState.REQUESTED);
                dao.insertConsulation(consultation);

                Receipt receipt = new Receipt("HPY-SOL-073", "hugoMed", consultation.id);
                dao.insertReceipt(receipt);

            });
        }
    };
}