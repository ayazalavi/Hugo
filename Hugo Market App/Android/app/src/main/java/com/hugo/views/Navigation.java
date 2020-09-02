package com.hugo.views;

import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.text.Editable;
import android.text.TextWatcher;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.databinding.BindingAdapter;
import androidx.fragment.app.Fragment;

import com.hugo.helpers.BrandAdapter;
import com.hugo.databinding.FragmentNavigationBinding;

public class Navigation extends Fragment {

    private FragmentNavigationBinding navigationBarBinding;
    private BrandAdapter adapter;
    private OnActivityCreated listner;

    @Override
    public void onAttach(@NonNull Context context) {
        super.onAttach(context);
        try {
            listner = (OnActivityCreated) context;
        }
        catch (ClassCastException exception) {
            throw new ClassCastException(context.toString() + " must implement OnActivityCreated");
        }
    }

    public interface OnActivityCreated {
        public void setNavigation();
    }

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
        navigationBarBinding = FragmentNavigationBinding.inflate(inflater, container, false);
        View view = navigationBarBinding.getRoot();
        return view;
    }

    @Override
    public void onDestroyView() {
        super.onDestroyView();
        navigationBarBinding = null;
    }

    @Override
    public void onActivityCreated(@Nullable Bundle savedInstanceState) {
        super.onActivityCreated(savedInstanceState);
        //setData(data);
        navigationBarBinding.leftButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                getActivity().finish();
            }
        });

        listner.setNavigation();
    }

    public void setNavigationSettings(NavigationSettings settings) {
        navigationBarBinding.setNavbar(settings);
    }

    public void setSearchBarClickListner(View.OnClickListener listner, boolean trigger) {
        navigationBarBinding.searchInput.setOnClickListener(listner);
        if (trigger) {
            navigationBarBinding.searchInput.performClick();
        }
    }

    public void setSearchBarHitEnterListner(View.OnKeyListener listner, TextWatcher watcher) {
        navigationBarBinding.searchInput.setOnKeyListener(listner);
        navigationBarBinding.searchInput.addTextChangedListener(watcher);
    }

    public void setSearchBarFocus(boolean focus) {
        navigationBarBinding.searchInput.setFocusableInTouchMode(focus);
    }

    public static class NavigationSettings {
        private final String title;
        private final int titleStyle;
        private final boolean showBack;
        private final int backButtonResource;
        private final boolean showRight;
        private final int rightButtonResource;

        public String getTitle() {
            return title;
        }

        public int getTitleStyle() {
            return titleStyle;
        }

        public boolean isShowBack() {
            return showBack;
        }

        public int getBackButtonResource() {
            return backButtonResource;
        }

        public boolean isShowRight() {
            return showRight;
        }

        public int getRightButtonResource() {
            return rightButtonResource;
        }

        public NavigationSettings(String title, int titleStyle, boolean showBack, int backButtonResource, boolean showRight, int rightButtonResource) {
            this.title = title;
            this.titleStyle = titleStyle;
            this.showBack = showBack;
            this.backButtonResource = backButtonResource;
            this.showRight = showRight;
            this.rightButtonResource = rightButtonResource;
        }

        @BindingAdapter({"android:background"})
        public static void setBackgroundResource(Button button, int resource) {
            button.setBackgroundResource(resource);
        }
    }

}