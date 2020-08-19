package com.hugo.views;

import android.content.Context;
import android.os.Bundle;

import com.google.android.material.tabs.TabLayout;
import com.google.android.material.tabs.TabLayoutMediator;
import com.hugo.R;
import com.hugo.databinding.ActivityStoreHomeBinding;
import com.hugo.databinding.FragmentStoreInformationBinding;
import com.hugo.databinding.StoreProductsBinding;
import com.hugo.helpers.HugoList;
import com.hugo.helpers.PromotionsAdapter;
import com.hugo.helpers.StoreProductsAdapter;
import com.hugo.viewmodels.Product;
import com.hugo.viewmodels.Store;
import com.hugo.viewmodels.StoreHomeViewModel;
import com.hugo.viewmodels.StorePromotions;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;
import androidx.fragment.app.Fragment;
import androidx.fragment.app.FragmentManager;
import androidx.fragment.app.FragmentTransaction;
import androidx.lifecycle.Observer;
import androidx.lifecycle.ViewModelProvider;
import androidx.viewpager2.adapter.FragmentStateAdapter;

import android.text.Spannable;
import android.text.SpannableString;
import android.text.style.TextAppearanceSpan;
import android.view.LayoutInflater;
import android.view.View;
import android.view.Menu;
import android.view.MenuItem;
import android.view.ViewGroup;

import java.util.HashMap;
import java.util.List;

public class StoreHome extends AppCompatActivity {

    private ActivityStoreHomeBinding activityStoreBinding;
    private StoreHomeViewModel model;
    private FragmentTransaction fragmentTransaction;
    private HugoList promotionsList;
    private StoreInformation storeInformation;
    private StoreData storeData;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        activityStoreBinding = ActivityStoreHomeBinding.inflate(getLayoutInflater());
        View view = activityStoreBinding.getRoot();
        setContentView(view);

        model = new ViewModelProvider(this).get(StoreHomeViewModel.class);
        model.setContext(this);

        FragmentManager fragmentManager = getSupportFragmentManager();
        fragmentTransaction = fragmentManager.beginTransaction();
        addHeader();
        addPromotions();
        addStoreProducts();
        fragmentTransaction.commit();

    }

    private void addStoreProducts() {
        storeData = new StoreData(model.getStoreData().getValue());
        fragmentTransaction.add(R.id.store_scrollview, storeData);
        model.getStoreData().observe(this, new Observer<HashMap<String, List<Product>>>() {
            @Override
            public void onChanged(HashMap<String, List<Product>> stringListHashMap) {
                //storeData.updateData(stringListHashMap);
            }
        });
    }

    private void addPromotions() {
        promotionsList = new HugoList();
        fragmentTransaction.add(R.id.store_scrollview, promotionsList);
        model.getPromotions().observe(this, new Observer<List<StorePromotions>>() {
            @Override
            public void onChanged(List<StorePromotions> promotions) {
                promotionsList.setTitle("PROMOCIONES");
                promotionsList.hideViewMore();
                promotionsList.setDataAdapter(new PromotionsAdapter(promotions, StoreHome.this));
            }
        });
    }

    private void addHeader() {
        storeInformation = new StoreInformation(model.getStore().getValue());
        fragmentTransaction.add(R.id.store_scrollview, storeInformation);
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        //getMenuInflater().inflate(R.menu.menu_home, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        // Handle action bar item clicks here. The action bar will
        // automatically handle clicks on the Home/Up button, so long
        // as you specify a parent activity in AndroidManifest.xml.
        int id = item.getItemId();

        //noinspection SimplifiableIfStatement
        if (id == R.id.action_home) {
            return true;
        }
        return super.onOptionsItemSelected(item);
    }

    public void goBack(View view) {
        finish();

    }

    public static class StoreInformation extends Fragment {

        private Store data;
        private FragmentStoreInformationBinding storeInformationBinding;

        public StoreInformation(Store data) {
            this.data = data;
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
            storeInformationBinding = FragmentStoreInformationBinding.inflate(getLayoutInflater());
            View view = storeInformationBinding.getRoot();
            return view;
        }

        @Override
        public void onDestroyView() {
            super.onDestroyView();
            storeInformationBinding = null;
        }

        @Override
        public void onActivityCreated(@Nullable Bundle savedInstanceState) {
            super.onActivityCreated(savedInstanceState);
            storeInformationBinding.setStore(this.data);
            SpannableString delivery = new SpannableString("DELIVERY \n\n "+this.data.time);
            delivery.setSpan(new TextAppearanceSpan(getActivity(), R.style.AppTheme_StoreButtonGray), 0,8, Spannable.SPAN_EXCLUSIVE_EXCLUSIVE);
            delivery.setSpan(new TextAppearanceSpan(getActivity(), R.style.AppTheme_StoreButtonPurple), 8, delivery.length(), Spannable.SPAN_EXCLUSIVE_EXCLUSIVE);
            storeInformationBinding.button1.setText(delivery);

            SpannableString opentimings = new SpannableString("HORARIO \n\n "+this.data.openTimings);
            opentimings.setSpan(new TextAppearanceSpan(getActivity(), R.style.AppTheme_StoreButtonGray), 0,7, Spannable.SPAN_EXCLUSIVE_EXCLUSIVE);
            opentimings.setSpan(new TextAppearanceSpan(getActivity(), R.style.AppTheme_StoreButtonPurple), 7, opentimings.length(), Spannable.SPAN_EXCLUSIVE_EXCLUSIVE);
            storeInformationBinding.button2.setText(opentimings);

            SpannableString ratings = new SpannableString("RATING \n\n "+this.data.openTimings);
            ratings.setSpan(new TextAppearanceSpan(getActivity(), R.style.AppTheme_StoreButtonGray), 0,6, Spannable.SPAN_EXCLUSIVE_EXCLUSIVE);
            ratings.setSpan(new TextAppearanceSpan(getActivity(), R.style.AppTheme_StoreButtonPurple), 6, ratings.length(), Spannable.SPAN_EXCLUSIVE_EXCLUSIVE);
            storeInformationBinding.button3.setText(ratings);
        }
    }

    public static class StoreData extends Fragment {

        private HashMap<String, List<Product>> data;
        private StoreProductsBinding storeProductsBinding;
        private StoreCategoriesAdapter storeCategoriesAdapter;
        private String[] keys;

        public StoreData(HashMap<String, List<Product>> data) {
            this.data = data;
            this.keys = new String[data.size()];
            this.data.keySet().toArray(keys);
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
            storeCategoriesAdapter = new StoreCategoriesAdapter(this, this.data);
            storeProductsBinding.pager.setAdapter(storeCategoriesAdapter);
            new TabLayoutMediator(storeProductsBinding.tabLayout, storeProductsBinding.pager, new TabLayoutMediator.TabConfigurationStrategy() {
                @Override
                public void onConfigureTab(@NonNull TabLayout.Tab tab, int position) {
                    tab.setText(keys[position]);
                }
            }).attach();
        }


        @Override
        public View onCreateView(LayoutInflater inflater, ViewGroup container,
                                 Bundle savedInstanceState) {
            // Inflate the layout for this fragment
            storeProductsBinding = StoreProductsBinding.inflate(getLayoutInflater());
            View view = storeProductsBinding.getRoot();
            return view;
        }

        @Override
        public void onDestroyView() {
            super.onDestroyView();
            storeProductsBinding = null;
        }

        @Override
        public void onActivityCreated(@Nullable Bundle savedInstanceState) {
            super.onActivityCreated(savedInstanceState);

        }

        public void updateData(HashMap<String, List<Product>> stringListHashMap) {
            this.data = storeCategoriesAdapter.data = stringListHashMap;
            this.keys = storeCategoriesAdapter.keys = (String[]) this.data.keySet().toArray();
            storeCategoriesAdapter.notifyDataSetChanged();
        }

        public class StoreCategoriesAdapter extends FragmentStateAdapter {

            public String[] keys;
            public HashMap<String, List<Product>> data;
            private HugoList hugoList;

            public StoreCategoriesAdapter(Fragment fragment, HashMap<String, List<Product>> data) {
                super(fragment);
                keys = new String[data.size()];
                data.keySet().toArray(keys);
                this.data = data;
            }

            @NonNull
            @Override
            public Fragment createFragment(int position) {
                // Return a NEW fragment instance in createFragment(int)
                HugoList hugoList = new HugoList();
                hugoList.setData(new StoreProductsAdapter(this.data.get(keys[position]), getContext()), keys[position]);
                return hugoList;
            }

            @Override
            public int getItemCount() {
                return keys.length;
            }
        }
    }
}