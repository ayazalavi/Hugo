package com.apps.client.juan.hugomed.activities;

import android.content.Intent;
import android.os.Bundle;
import android.text.SpannableString;
import android.text.SpannedString;
import android.text.TextUtils;
import android.util.DisplayMetrics;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;

import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;
import androidx.databinding.BindingAdapter;

import com.apps.client.juan.hugomed.R;
import com.apps.client.juan.hugomed.databinding.ConsulatationslideupBinding;
import com.apps.client.juan.hugomed.helpers.SpannableHelper;

import java.util.Timer;
import java.util.TimerTask;

public class ConsultationSlideup extends AppCompatActivity {
    private ConsulatationslideupBinding consultationBinding;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        consultationBinding = ConsulatationslideupBinding.inflate(getLayoutInflater());
        consultationBinding.setDoctor(DoctorsListing.selectedDoctor);
        String str = getResources().getQuantityString(R.plurals.disponsible_en_popover, DoctorsListing.selectedDoctor.availabilityMins, DoctorsListing.selectedDoctor.availabilityMins);
        SpannableString str1 = SpannableHelper.shared.getSpannableString(str, R.style.popover_subtitle_available_in_attr, this);
        consultationBinding.availableIn.setText(str1, TextView.BufferType.SPANNABLE);
        setContentView(consultationBinding.getRoot());
    }


    public void closePopover(View view) {
        finish();
        new Timer().schedule(new TimerTask() {
            @Override
            public void run() {
                Intent intent = new Intent(ConsultationSlideup.this, StartConsultation.class);
                startActivity(intent);
                overridePendingTransition(R.anim.slide_in_left, R.anim.slide_out_left);
            }
        }, 1000);
    }
}