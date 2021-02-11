package com.apps.client.juan.hugomed.activities;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.util.Log;
import android.view.View;

import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;
import androidx.lifecycle.ViewModelProvider;

import com.apps.client.juan.hugomed.R;
import com.apps.client.juan.hugomed.data.entities.ConsulationState;
import com.apps.client.juan.hugomed.data.entities.Consultation;
import com.apps.client.juan.hugomed.data.helpers.General;
import com.apps.client.juan.hugomed.data.helpers.HugoMedDatabase;
import com.apps.client.juan.hugomed.data.viewmodels.DoctorsViewModel;
import com.apps.client.juan.hugomed.databinding.CallsettingsBinding;
import com.apps.client.juan.hugomed.databinding.IncallBinding;
import com.opentok.android.Publisher;
import com.opentok.android.Subscriber;

public class InCall extends AppCompatActivity {
    private DoctorsViewModel viewModel;
    public static IncallBinding incall;
    private String TAG = "In-Call";

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        incall = IncallBinding.inflate(getLayoutInflater());
        setContentView(incall.getRoot());
        if (CallSettings.mVideoView != null) {
            incall.subscriber.addView(CallSettings.mVideoView);
            CallSettings.mSubscriber.setSubscribeToAudio(true);
        }
        setSupportActionBar(IncallBinding.inflate(getLayoutInflater()).myToolbar);
        getSupportActionBar().setDisplayShowTitleEnabled(false);
        General.hide_bottom_nav(this);
    }

    public void endCall(View view) {
        CallSettings.mSession.disconnect();
        Intent intent = new Intent(this, Receipt.class);
        startActivity(intent);
        overridePendingTransition(R.anim.slide_in_left, R.anim.slide_out_left);
    }

    public void toggleAudio(View view) {
        view.setSelected(!view.isSelected());
        CallSettings.mSubscriber.setSubscribeToAudio(!view.isSelected());
    }

    public void toggleVideo(View view) {
        view.setSelected(!view.isSelected());
        CallSettings.mSubscriber.setSubscribeToVideo(!view.isSelected());
    }

    @Override
    protected void onDestroy() {
        incall.subscriber.removeAllViews();
        super.onDestroy();
        if (CallSettings.mSubscriber != null) {
            CallSettings.mSubscriber.setSubscribeToAudio(false);
        }
    }

    public class ConnectionReceiver extends BroadcastReceiver {

        @Override
        public void onReceive(Context context, Intent intent) {
            Log.v(TAG, "add view");

        }
    }
}
