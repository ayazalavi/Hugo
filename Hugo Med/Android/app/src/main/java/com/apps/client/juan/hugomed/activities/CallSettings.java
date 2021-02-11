package com.apps.client.juan.hugomed.activities;

import android.Manifest;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.util.Log;
import android.view.View;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;
import androidx.lifecycle.ViewModelProvider;

import com.apps.client.juan.hugomed.R;
import com.apps.client.juan.hugomed.data.entities.ConsulationState;
import com.apps.client.juan.hugomed.data.entities.Consultation;
import com.apps.client.juan.hugomed.data.entities.Receipt;
import com.apps.client.juan.hugomed.data.helpers.General;
import com.apps.client.juan.hugomed.data.helpers.HugoMedDatabase;
import com.apps.client.juan.hugomed.data.viewmodels.DoctorsViewModel;
import com.apps.client.juan.hugomed.databinding.CallsettingsBinding;
import com.apps.client.juan.hugomed.databinding.IncallBinding;
import com.apps.client.juan.hugomed.service.APIRequest;
import com.opentok.android.OpentokError;
import com.opentok.android.Publisher;
import com.opentok.android.PublisherKit;
import com.opentok.android.Session;
import com.opentok.android.Stream;
import com.opentok.android.Subscriber;

import android.opengl.GLSurfaceView;

import java.util.Date;

import pub.devrel.easypermissions.AfterPermissionGranted;
import pub.devrel.easypermissions.EasyPermissions;

public class CallSettings extends AppCompatActivity implements Session.SessionListener, PublisherKit.PublisherListener {
    private static final int RC_VIDEO_APP_PERM = 1;
    private static final String LOG_TAG = "CALL-SETTINGS";
    private DoctorsViewModel viewModel;
    private CallsettingsBinding callSettings;
    public static Session mSession;
    public static Publisher mPublisher;
    public static Subscriber mSubscriber;
    public static View mVideoView;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        callSettings = CallsettingsBinding.inflate(getLayoutInflater());
        setContentView(callSettings.getRoot());

        HugoMedDatabase.databaseWriteExecutor.execute(() -> {

        });

        setSupportActionBar(callSettings.myToolbar);
        getSupportActionBar().setDisplayShowTitleEnabled(false);
        callSettings.myToolbar.setNavigationOnClickListener(v -> {
            finish();
        });

        requestPermissions();
        General.hide_bottom_nav(this);
    }

    public void startCall(View view) {
        Intent intent = new Intent(this, InCall.class);
        startActivity(intent);
        overridePendingTransition(R.anim.slide_in_left, R.anim.slide_out_left);
    }

    @Override
    public void onRequestPermissionsResult(int requestCode, @NonNull String[] permissions, @NonNull int[] grantResults) {

        super.onRequestPermissionsResult(requestCode, permissions, grantResults);
        EasyPermissions.onRequestPermissionsResult(requestCode, permissions, grantResults, this);
    }

    @AfterPermissionGranted(RC_VIDEO_APP_PERM)
    private void requestPermissions() {
        String[] perms = { Manifest.permission.INTERNET, Manifest.permission.CAMERA, Manifest.permission.RECORD_AUDIO };
        if (EasyPermissions.hasPermissions(this, perms)) {
            mSession = new Session.Builder(this, APIRequest.current_comm_keys.api, APIRequest.current_comm_keys.session).build();
            mSession.setSessionListener(this);
            mSession.connect(APIRequest.current_comm_keys.videotoken);
        } else {
            EasyPermissions.requestPermissions(this, "This app needs access to your camera and mic to make video calls", RC_VIDEO_APP_PERM, perms);
        }
    }

    @Override
    public void onConnected(Session session) {
        Log.i(LOG_TAG, "Session Connected");
        mPublisher = new Publisher.Builder(this).build();
        mPublisher.setPublisherListener(this);
        callSettings.publisher.addView(mPublisher.getView());
        if (mPublisher.getView() instanceof GLSurfaceView){
           // ((GLSurfaceView) mPublisher.getView()).setZOrderOnTop(true);
        }
        mSession.publish(mPublisher);
    }

    @Override
    public void onDisconnected(Session session) {
        Log.i(LOG_TAG, "Session Disconnected");
        mSession = null;
        mPublisher = null;
        mSubscriber = null;
    }

    @Override
    public void onStreamReceived(Session session, Stream stream) {
        Log.i(LOG_TAG, "Stream Received");
        if (mSubscriber == null) {
            mSubscriber = new Subscriber.Builder(this, stream).build();
            mSession.subscribe(mSubscriber);
            mVideoView = mSubscriber.getView();
            if (InCall.incall != null) {
                InCall.incall.subscriber.addView(mVideoView);
            }
        }
    }

    @Override
    public void onStreamDropped(Session session, Stream stream) {
        Log.i(LOG_TAG, "Stream Dropped");
    }

    @Override
    public void onError(Session session, OpentokError opentokError) {
        Log.e(LOG_TAG, "Session error: " + opentokError.getMessage());
    }

    @Override
    public void onStreamCreated(PublisherKit publisherKit, Stream stream) {
        Log.i(LOG_TAG, "Publisher onStreamCreated");
    }

    @Override
    public void onStreamDestroyed(PublisherKit publisherKit, Stream stream) {
        Log.i(LOG_TAG, "Publisher onStreamDestroyed");
    }

    @Override
    public void onError(PublisherKit publisherKit, OpentokError opentokError) {
        Log.e(LOG_TAG, "Publisher error: " + opentokError.getMessage());
    }

    public void toggleAudio(View view) {
        view.setSelected(!view.isSelected());
        mPublisher.setPublishAudio(!view.isSelected());
    }

    public void toggleVideo(View view) {
        view.setSelected(!view.isSelected());
        mPublisher.setPublishVideo(!view.isSelected());
    }

    @Override
    protected void onDestroy() {
        if (mSession != null) {
            mSession.disconnect();
        }
        super.onDestroy();
    }

}
