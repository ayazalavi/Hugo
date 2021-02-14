package com.apps.client.juan.hugomed.activities;

import androidx.appcompat.app.AppCompatActivity;
import androidx.fragment.app.FragmentActivity;
import androidx.lifecycle.ViewModelProvider;
import androidx.recyclerview.widget.RecyclerView;

import android.content.Intent;
import android.os.Bundle;
import android.text.SpannableString;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.ImageButton;
import android.widget.TextView;

import com.apps.client.juan.hugomed.R;
import com.apps.client.juan.hugomed.data.viewmodels.OnBoardingViewModel;
import com.apps.client.juan.hugomed.databinding.OnboardingBinding;
import com.apps.client.juan.hugomed.databinding.OnboardingDetailedBinding;
import com.apps.client.juan.hugomed.databinding.OnboardingSimpleBinding;
import com.apps.client.juan.hugomed.helpers.SpannableHelper;

import java.util.Timer;
import java.util.TimerTask;

public class OnBoarding extends AppCompatActivity {

    private OnboardingSimpleBinding simpleBinding;
    private OnboardingDetailedBinding detailedBinding;
    private OnBoardingViewModel viewModel;
    private OnboardingBinding boarding;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        boarding = OnboardingBinding.inflate(getLayoutInflater());
        setContentView(boarding.getRoot());
        viewModel = new ViewModelProvider(this).get(OnBoardingViewModel.class);
        boarding.pager.setAdapter(new Adapter(viewModel));
        setSupportActionBar(boarding.myToolbar);
    }

    public void gotoDoctorsListing(View view) {
        Intent intent = new Intent(this, DoctorsListing.class);
        startActivity(intent);
        overridePendingTransition(R.anim.slide_in_left, R.anim.slide_out_left);
    }

    public static class MyViewHolder extends RecyclerView.ViewHolder {
        // each data item is just a string in this case
        public MyViewHolder(View v) {
            super(v);
        }
    }

    class Adapter extends RecyclerView.Adapter<OnBoarding.MyViewHolder> {
        // Provide a suitable constructor (depends on the kind of dataset)
        OnBoardingViewModel mViewModel;

        @Override
        public int getItemViewType(int position) {
            return position;
        }

        public Adapter(OnBoardingViewModel viewModel) {
            mViewModel = viewModel;
        }

         // Create new views (invoked by the layout manager)
        @Override
        public OnBoarding.MyViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
            MyViewHolder myViewHolder;
            switch (viewType) {
                case 2:
                    detailedBinding = OnboardingDetailedBinding.inflate(getLayoutInflater(), parent, false);
                    myViewHolder = new MyViewHolder(detailedBinding.getRoot());
                    break;
                default:
                    simpleBinding = OnboardingSimpleBinding.inflate(getLayoutInflater(), parent, false);
                    myViewHolder = new MyViewHolder(simpleBinding.getRoot());
                    break;
            }
            return myViewHolder;
        }

        // Replace the contents of a view (invoked by the layout manager)
        @Override
        public void onBindViewHolder(MyViewHolder holder, int position) {
            // - get element from your dataset at this position
            // - replace the contents of the view with that element
            switch (position) {
                case 2:
                    setClickListners(detailedBinding.pager);
                    detailedBinding.setData(mViewModel.onboarding[position]);
                    detailedBinding.pager.getChildAt(position).setSelected(true);
                    SpannableString desc = SpannableHelper.shared.getSpannableString(mViewModel.onboarding[position].description, R.style.onboarding_desc_3_attr, OnBoarding.this);
                    SpannableString terms = SpannableHelper.shared.getSpannableString(getResources().getString(R.string.onboard_terms), R.style.onboarding_terms_attr, OnBoarding.this);
                    detailedBinding.onboardingDesc.setText(desc, TextView.BufferType.SPANNABLE);
                    detailedBinding.terms.setText(terms, TextView.BufferType.SPANNABLE);
                   // detailedBinding.terms.setTextAppearance(OnBoarding.this, R.style.app_main_desc);
                    break;
                default:
                    setClickListners(simpleBinding.pager);
                    simpleBinding.setData(mViewModel.onboarding[position]);
                    simpleBinding.pager.getChildAt(position).setSelected(true);
                    SpannableString desc_ = SpannableHelper.shared.getSpannableString(mViewModel.onboarding[position].description, position == 0 ? R.style.onboarding_desc_1_attr : R.style.onboarding_desc_2_attr, OnBoarding.this);
                    simpleBinding.onboardingDesc.setText(desc_, TextView.BufferType.SPANNABLE);
               //     simpleBinding.onboardingDesc.setTextAppearance(OnBoarding.this, R.style.app_main_desc);
                    break;
            }

        }

        void setClickListners(ViewGroup v) {
            for (int i = 0; i < v.getChildCount(); i++) {
                ImageButton button = (ImageButton) v.getChildAt(i);
                int finalI = i;
                button.setOnClickListener(new View.OnClickListener() {
                    @Override
                    public void onClick(View v) {
                        boarding.pager.setCurrentItem(finalI, true);
                    }
                });
            }
        }

        // Return the size of your dataset (invoked by the layout manager)
        @Override
        public int getItemCount() {
            return mViewModel.onboarding.length;
        }
    }
}

