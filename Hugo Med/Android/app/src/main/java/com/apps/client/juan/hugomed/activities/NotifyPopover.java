package com.apps.client.juan.hugomed.activities;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;

import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;

import com.apps.client.juan.hugomed.R;
import com.apps.client.juan.hugomed.data.helpers.General;

import java.util.Timer;
import java.util.TimerTask;

public class NotifyPopover extends AppCompatActivity {
    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.notifypopover);
        General.hide_bottom_nav(this);
    }

    public void closePopover(View view) {
        Intent intent = new Intent(NotifyPopover.this, EnterConsultationSlideUp.class);
        startActivity(intent);
        overridePendingTransition(R.anim.slide_in, R.anim.slide_out);
        new Timer().schedule(new TimerTask() {
            @Override
            public void run() {
                finish();
            }
        }, 600);
    }
}