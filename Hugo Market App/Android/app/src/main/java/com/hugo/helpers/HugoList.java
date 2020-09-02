package com.hugo.helpers;

import android.content.Context;
import android.os.Bundle;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.fragment.app.Fragment;
import androidx.recyclerview.selection.ItemDetailsLookup;
import androidx.recyclerview.selection.OnItemActivatedListener;
import androidx.recyclerview.selection.SelectionTracker;
import androidx.recyclerview.selection.StableIdKeyProvider;
import androidx.recyclerview.selection.StorageStrategy;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import android.view.LayoutInflater;
import android.view.MotionEvent;
import android.view.View;
import android.view.ViewGroup;

import com.hugo.helpers.BrandAdapter;
import com.hugo.helpers.StoreProductsAdapter;
import com.hugo.viewmodels.HomeBrand;
import com.hugo.databinding.FragmentBrandBinding;

import java.util.List;


public class HugoList extends Fragment {

    private List<HomeBrand> data;
    private FragmentBrandBinding brand;
    private BrandAdapter adapter;
    private StoreProductsAdapter storeProductsAdapter;
    private String title;

    public void setData(StoreProductsAdapter storeProductsAdapter, String title) {
        this.storeProductsAdapter = storeProductsAdapter;
        this.title = title;
    }

    public interface OnItemSelectedListner {
        public void OnItemSelected();
    }

    @Override
    public void onAttach(@NonNull Context context) {
        super.onAttach(context);
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
        brand = FragmentBrandBinding.inflate(inflater, container, false);
        View view = brand.getRoot();
        return view;
    }

    @Override
    public void onDestroyView() {
        super.onDestroyView();
        brand = null;
    }

    @Override
    public void onActivityCreated(@Nullable Bundle savedInstanceState) {
        super.onActivityCreated(savedInstanceState);
        //setData(data);

        if (this.storeProductsAdapter != null) {
            setDataAdapter(storeProductsAdapter);
            setTitle(title);
        }
    }

    public void setDataAdapter(RecyclerView.Adapter adapter) {
        brand.brandList.setHasFixedSize(true);
        brand.brandList.setAdapter(adapter);
    }

    public void hideViewMore() {
        brand.viewMore.setVisibility(View.GONE);
    }

    public void hideTitle() {
        brand.listTitle.setVisibility(View.GONE);
    }

    public void setTitle(String title) {
        brand.listTitle.setText(title);
    }

    public void makeListVertical() {
        brand.brandList.setLayoutManager(new LinearLayoutManager(getActivity(), LinearLayoutManager.VERTICAL, false));
    }
}