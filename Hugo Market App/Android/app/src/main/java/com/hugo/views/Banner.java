package com.hugo.views;

import android.os.Bundle;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.fragment.app.Fragment;

import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import com.hugo.viewmodels.HomeBanner;
import com.hugo.databinding.FragmentBannerBinding;

/**
 * A simple {@link Fragment} subclass.
 * Use the {@link Header#newInstance} factory method to
 * create an instance of this fragment.
 */

public class Banner extends Fragment {

    private HomeBanner data;
    private FragmentBannerBinding banner;

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
    }

    @Override
    public void onViewCreated(@NonNull View view, @Nullable Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        // Inflate the layout for this fragment
        banner = FragmentBannerBinding.inflate(inflater, container, false);
        View view = banner.getRoot();
        return view;
    }

    @Override
    public void onDestroyView() {
        super.onDestroyView();
        banner = null;
    }

    @Override
    public void onActivityCreated(@Nullable Bundle savedInstanceState) {
        super.onActivityCreated(savedInstanceState);
        //setData(data);
    }

    public void setData(HomeBanner data) {
        this.data = data;
        final int resourceId = getResources().getIdentifier(data.getPhoto(), "drawable", getActivity().getPackageName());
        banner.banner.setImageDrawable(getResources().getDrawable(resourceId));
        banner.title.setText(data.getTitle());
        banner.subtitle.setText(data.getSubtitle());
    }
}