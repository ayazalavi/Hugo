package com.apps.client.juan.hugomed.service;

import android.app.Service;
import android.content.Context;
import android.content.Intent;
import android.os.AsyncTask;
import android.os.Binder;
import android.os.Bundle;
import android.os.Handler;
import android.os.HandlerThread;
import android.os.IBinder;
import android.os.Looper;
import android.os.Message;
import android.util.Log;
import android.widget.Toast;

import androidx.annotation.NonNull;
import androidx.constraintlayout.solver.ArrayLinkedVariables;
import androidx.work.Worker;
import androidx.work.WorkerParameters;

import com.apps.client.juan.hugomed.activities.DoctorsListing;
import com.apps.client.juan.hugomed.data.entities.Appointment;
import com.apps.client.juan.hugomed.data.entities.Appointment_Response;
import com.apps.client.juan.hugomed.data.entities.Communication;
import com.apps.client.juan.hugomed.data.entities.Company;
import com.apps.client.juan.hugomed.data.entities.Doctor;
import com.apps.client.juan.hugomed.data.entities.DoctorWithSpecialities;
import com.apps.client.juan.hugomed.data.entities.New_Appointment;
import com.apps.client.juan.hugomed.data.entities.Patient;
import com.apps.client.juan.hugomed.data.helpers.General;
import com.apps.client.juan.hugomed.data.helpers.HugoMedDatabase;
import com.apps.client.juan.hugomed.data.helpers.MainRepository;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.google.gson.JsonSyntaxException;

import org.json.JSONObject;
import org.otwebrtc.DataChannel;

import java.io.IOException;
import java.util.List;

import okhttp3.Interceptor;
import okhttp3.MediaType;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.RequestBody;
import okhttp3.Response;
import okio.Buffer;

public class APIRequest extends Service {
    private Looper requestLooper, mainLooper;
    private MainDataHandler mainHandler;
    private RequestDataHandler requestHandler;
    OkHttpClient client = new OkHttpClient();
    private MainRepository mRepository;
    Gson gson = new Gson();
    public static Patient current_patient;
    public static Company microuniverse_company;
    public static Appointment_Response current_appointment;
    public static Communication current_comm_keys;
    public static com.apps.client.juan.hugomed.data.entities.Service current_service;
    private final IBinder binder = new LocalBinder();
    public String response = null;
    private String make_appointment_url;
    private String TAG = "API-REQUEST";
    public Doctor current_doctor;

    void showMessage(String message) {
        new Handler(Looper.getMainLooper()).post(() -> {

            //Toast.makeText(APIRequest.this, message, Toast.LENGTH_LONG);

        });
    }
    // Handler that receives messages from the thread
    private final class MainDataHandler extends Handler {
        public MainDataHandler(Looper looper) {
            super(looper);
        }
        @Override
        public void handleMessage(Message msg) {

            try {
                MED_API_URL currentRequest = (MED_API_URL) msg.obj;
                String url = APIUrl.url(currentRequest);
                String response = APIRequest.this.fetch(url);
                switch (currentRequest) {
                    case GET_PATIENT_BY_ID:
                        Log.v(TAG, url);
                        if (response != null) {
                            Patient[] patients = gson.fromJson(response, Patient[].class);
                            if (patients.length > 0) {
                                current_patient = patients[0];
                                long id_ = mRepository.insertPatient(current_patient);
                                MED_API_URL arg = MED_API_URL.GET_COMPANY_CATALOG;
                                arg.param1 = current_patient.country_id+"";
                                mainHandler.sendMessage(mainHandler.obtainMessage(0, arg));
                            }
                            else {
                                showMessage("patient not inserted");
                            }
                        }
                        break;
                    case GET_COMPANY_CATALOG:
                        Log.v(TAG, url);
                        if (response != null) {
                            Company[] companies = gson.fromJson(response, Company[].class);
                            List<Company> companies_ = mRepository.insertCompanies(companies);
                          //  Log.v("Company catalog", companies_.size()+"");
                            if (companies_.size() > 0) {
                                microuniverse_company = companies_.get(0);
                                MED_API_URL arg = MED_API_URL.GET_DOCTORS_BY_MICROUNIVERSE;
                                arg.param1 = "5";
                                mainHandler.sendMessage(mainHandler.obtainMessage(0, arg));
                            }
                            else {
                                showMessage("company not found");
                            }
                        }
                        break;
                    case GET_DOCTORS_BY_MICROUNIVERSE:
                        Log.v(TAG, url);
                        if (response != null) {
                            Doctor[] doctors = gson.fromJson(response, Doctor[].class);
                            List<DoctorWithSpecialities> doctors_ = mRepository.insertOnDemandDoctors(doctors);
                            if (doctors_.size() > 0) {
                                Thread.sleep(5000);
                                mainHandler.sendMessage(mainHandler.obtainMessage(0, msg.obj));
                            }
                            else {
                                showMessage("company not found");
                            }
                        }
                        break;
                }

            } catch (JsonSyntaxException | InterruptedException e) {
                e.printStackTrace();
            }
            // Stop the service using the startId, so that we don't stop
            // the service in the middle of handling another job
        }

    }

    private String fetch(String url) {
        Request request = new Request.Builder()
                .url(url)
                .addHeader("Authorization", "Api-Key "+APIUrl.API_KEY)
                .addHeader("Accept", "application/json")
                .addHeader("Content-Type", "application/json")
                .build();

        try (Response response = client.newCall(request).execute()) {
            return response.body().string();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return null;
    }

    class LoggingInterceptor implements Interceptor {
        @Override public Response intercept(Interceptor.Chain chain) throws IOException {
            Request request = chain.request();
            Log.v(TAG, String.format(" %s on %s%n%s%n%s",
                    request.url(), chain.connection(), request.headers(), request.method()));
            if (request.body() != null && request.header("Content-Type") != null) {
                return chain.proceed(request);
                //Log.v("response", response.body().toString());
            }
            String json = gson.toJson(new New_Appointment(0, "D", DoctorsListing.selectedDoctor.doctor.id,
                    current_patient.email, "C", current_service.id, "Dolor de Estómago", "K", 5, true), New_Appointment.class);
            RequestBody body = RequestBody.create(
                    json,
                    MediaType.parse("application/json; charset=utf-8")
            );
            Request compressedRequest = request.newBuilder()
                    .header("User-Agent", "OkHttp Bot")
                    .header("Accept", "application/json")
                    .header("Content-Type", "application/json")
                    .post(body)
                    .build();
            Log.v(TAG, String.format(" %s on %s%n%s%n%s",
                    compressedRequest.url(), chain.connection(), compressedRequest.headers(), compressedRequest.method()));
            return chain.proceed(compressedRequest);
        }
    }

    public void make_an_appointment(String url) throws Exception {
        make_appointment_url = url;
        String json = String.format("{\"appointment_kind\":\"C\",\"company_id\":5,\"doctor_id\":%d,\"is_ondemand\":true,\"motive\":\"Dolor de Estómago\",\"patient_email\":\"%s\",\"place_id\":0,\"service_id\":%d,\"status_list\":\"K\",\"type\":\"D\"}",
                DoctorsListing.selectedDoctor.doctor.id, current_patient.email, current_service.id);

        final MediaType MEDIA_TYPE_MARKDOWN
                = MediaType.parse("application/json; charset=utf-8");
        Log.v(TAG, json);
        Request request = new Request.Builder()
                .url(url)
                .header("Authorization", "Api-Key UwF7j4gj.WYTKstv0lvhqXPr2kuVmLzP8OerkPpRj")
                .header("User-Agent", "OkHttp Bot")
                .header("Accept", "application/json")
                .header("Content-Type", "application/json")
                .post(RequestBody.create(MEDIA_TYPE_MARKDOWN, json))
                .build();

        try (Response response_ = client.newCall(request).execute()) {
            if (!response_.isSuccessful()) throw new IOException("Unexpected code " + response);
            response = response_.body().string();
            saveAppointmentandGetCommKeys();
            //System.out.println(response_.body().string());
        }
    }

    private final class RequestDataHandler extends Handler {
        public RequestDataHandler(Looper looper) {
            super(looper);
        }
        @Override
        public void handleMessage(Message msg) {
            // Normally we would do some work here, like download a file.
            // For our sample, we just sleep for 5 seconds.
            MED_API_URL currentRequest = (MED_API_URL) msg.obj;
            String url = APIUrl.url(currentRequest);
            Log.v(TAG, url);
            switch (currentRequest) {
                case REGISTER_ON_DEMAND_APPOINTMENT:
                    break;
                case GET_DOCTOR_BY_ID:
                    String response_ = APIRequest.this.fetch(url);
                    DoctorsListing.selectedDoctor.doctor = gson.fromJson(response_, Doctor.class);
                    try {
                        Thread.sleep(5000);
                        requestHandler.sendMessage(requestHandler.obtainMessage(0, msg.obj));
                    } catch (InterruptedException e) {
                        e.printStackTrace();
                    }
                default:
                    response = APIRequest.this.fetch(url);
                    break;
            }
        }
    }

    @Override
    public void onCreate() {
        HandlerThread thread = new HandlerThread("setup app", Thread.MAX_PRIORITY);
        thread.start();
        HandlerThread thread2 = new HandlerThread("request data", Thread.MAX_PRIORITY);
        thread2.start();
        requestLooper = thread2.getLooper();
        mainLooper = thread.getLooper();
        mainHandler = new MainDataHandler(mainLooper);
        requestHandler = new RequestDataHandler(requestLooper);
    }

    @Override
    public int onStartCommand(Intent intent, int flags, int startId) {
        //Toast.makeText(this, "service starting", Toast.LENGTH_SHORT).show();
        AsyncTask.execute(new Runnable() {
            @Override
            public void run() {
                mRepository = new MainRepository(APIRequest.this.getApplication());
                Message msg = mainHandler.obtainMessage();
                MED_API_URL arg = MED_API_URL.GET_PATIENT_BY_ID;
                arg.param1 = "497";
                msg.obj = arg;
                mainHandler.sendMessage(msg);
            }
        });
        // If we get killed, after returning from here, restart
        return START_STICKY;
    }

    @Override
    public IBinder onBind(Intent intent) {
        // A client is binding to the service with bindService()
        //Toast.makeText(APIRequest.this, "service binded", Toast.LENGTH_SHORT).show();
        response = null;
        requestData(intent);
        return binder;
    }

    public void requestData(Intent intent)
    {
        Bundle extras = intent.getExtras();
        try {
            Log.v(TAG, "requesting data");
            MED_API_URL url = (MED_API_URL) General.deserialize(extras.getByteArray("med_api_url"));
            Message msg = requestHandler.obtainMessage();
            msg.obj = url;
            requestHandler.sendMessage(msg);
        } catch (IOException | NullPointerException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }

    }
    @Override
    public boolean onUnbind(Intent intent) {
        // All clients have unbound with unbindService()
      //  Toast.makeText(this, "service unbinded", Toast.LENGTH_SHORT).show();
        return true;
    }
    @Override
    public void onRebind(Intent intent) {
        // A client is binding to the service with bindService(),
        // after onUnbind() has already been called
       // Toast.makeText(this, "service rebinded", Toast.LENGTH_SHORT).show();
        response = null;
        requestData(intent);
    }
    @Override
    public void onDestroy() {
        // The service is no longer used and is being destroyed
        Log.v(TAG, "destroyed");
        mainLooper.getThread().interrupt();
        mainHandler.removeMessages(0);
        requestLooper.getThread().interrupt();
    }

    public void saveService() {
        com.apps.client.juan.hugomed.data.entities.Service services[] = gson.fromJson(response, com.apps.client.juan.hugomed.data.entities.Service[].class);
        if (services.length > 0) {
            current_service = services[0];
        }
    }

    public void saveAppointmentandGetCommKeys() {
        current_appointment = gson.fromJson(response, Appointment_Response.class);
        MED_API_URL url = MED_API_URL.GET_COMM_KEYS_APPOINTMENT;
        url.param1 = current_appointment.code;
        String response_ = this.fetch(APIUrl.url(url));
        current_comm_keys = gson.fromJson(response_, Communication.class);
    }

    public class LocalBinder extends Binder {
        public APIRequest getService() {
            // Return this instance of LocalService so clients can call public methods
            return APIRequest.this;
        }
    }
}
