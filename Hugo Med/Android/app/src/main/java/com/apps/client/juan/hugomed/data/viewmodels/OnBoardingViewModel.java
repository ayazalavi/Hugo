package com.apps.client.juan.hugomed.data.viewmodels;

import android.app.Application;
import android.graphics.drawable.Drawable;

import androidx.lifecycle.AndroidViewModel;

import com.apps.client.juan.hugomed.R;
import com.apps.client.juan.hugomed.data.helpers.MainRepository;

public class OnBoardingViewModel extends AndroidViewModel {

    public OnBoardingStruct[] onboarding;

    public OnBoardingViewModel (Application application) {
        super(application);
        onboarding = new OnBoardingStruct[] {
            new OnBoardingStruct(application.getResources().getString(R.string.onboard_title_1),
                    application.getResources().getString(R.string.onboard_desc_1),
                    application.getResources().getDrawable(R.drawable.onboarding_med01)),
            new OnBoardingStruct(application.getResources().getString(R.string.onboard_title_2),
                    application.getResources().getString(R.string.onboard_desc_2),
                    application.getResources().getDrawable(R.drawable.onboarding_med02)),
            new OnBoardingStruct(application.getResources().getString(R.string.onboard_title_3),
                    application.getResources().getString(R.string.onboard_desc_3),
                    application.getResources().getDrawable(R.drawable.onboarding_med03))
        };
    }

    public class OnBoardingStruct {
        public String title, description;
        public Drawable image;

        public OnBoardingStruct(String title, String description, Drawable image) {
            this.title = title;
            this.description = description;
            this.image = image;
        }
    }

}
