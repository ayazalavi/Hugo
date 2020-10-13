package com.hugo.views;

import android.content.Context;
import android.content.res.Resources;
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
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.Menu;
import android.view.MenuItem;
import android.view.ViewGroup;
import android.view.ViewTreeObserver;
import android.view.animation.AlphaAnimation;
import android.view.animation.TranslateAnimation;
import android.widget.LinearLayout;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Timer;
import java.util.TimerTask;

public class StoreHome extends AppCompatActivity {

    private ActivityStoreHomeBinding activityStoreBinding;
    private StoreHomeViewModel model;
    private FragmentTransaction fragmentTransaction;
    private HugoList promotionsList;
    private StoreInformation storeInformation;
    private StoreData storeData;
    private StoreCategories storeCategories;
    private FragmentStoreInformationBinding storeInformationBinding;
    private ViewTreeObserver.OnScrollChangedListener scrollListner;

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
        //addStoreProducts();
        addCategories();
        addStoreProducts();
        fragmentTransaction.commit();

        activityStoreBinding.myToolbar.setNavigationOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                finish();
            }
        });
        activityStoreBinding.scrollview.setSmoothScrollingEnabled(true);
        scrollListner = new ViewTreeObserver.OnScrollChangedListener() {
            @Override
            public void onScrollChanged() {
               int scrollY = activityStoreBinding.scrollview.getScrollY();
                Log.v("scroll", scrollY+"");
                activityStoreBinding.navTitle.setText(model.getStore().getValue().name);
                TabLayout tabLayout = activityStoreBinding.storeScrollview.getChildAt(2).findViewById(R.id.tab_layout);
                float categoriesy = activityStoreBinding.storeScrollview.getChildAt(2).getY();
                float categoriesh = tabLayout.getMeasuredHeight();
                float hugoh = ((LinearLayout)findViewById(R.id.pager)).getChildAt(0).getMeasuredHeight();
                int someIndex = (int) Math.ceil((activityStoreBinding.scrollview.getScrollY() - categoriesy)/hugoh);
                Log.v("tab-1", someIndex+"");
                Log.v("scroll1", categoriesy+" ");

                 if (someIndex >= 0 && activityStoreBinding.tabLayout2.getSelectedTabPosition() != someIndex) {
                    Log.v("tab-2", activityStoreBinding.tabLayout2.getSelectedTabPosition()+"");
                    Log.v("selectedTab", activityStoreBinding.scrollview.getScrollY()+" "+categoriesy+" "+hugoh);
                    final TabLayout.Tab tab2 = activityStoreBinding.tabLayout2.getTabAt(someIndex);
                    activityStoreBinding.tabLayout2.setTag("select");
                    activityStoreBinding.tabLayout2.selectTab(tab2, true);

                     final TabLayout.Tab tab = tabLayout.getTabAt(someIndex);
                     tabLayout.setTag("select");
                     tabLayout.selectTab(tab, true);
                }

                if (activityStoreBinding.scrollview.getScrollY() > categoriesy - categoriesh  && activityStoreBinding.tabLayout2.getVisibility() == View.GONE) {
                    activityStoreBinding.tabLayout2.setVisibility(View.VISIBLE);
                }
                else if(activityStoreBinding.scrollview.getScrollY() < categoriesy - categoriesh && activityStoreBinding.tabLayout2.getVisibility() == View.VISIBLE){
                    activityStoreBinding.tabLayout2.setVisibility(View.GONE);
                }


                if (scrollY > 260 && activityStoreBinding.myToolbar.getVisibility() == View.GONE) {
                    Log.v("scroll1", activityStoreBinding.myToolbar.getHeight()+"");
                    Log.v("scroll1", activityStoreBinding.myToolbar.getMeasuredHeight()+"");
                    activityStoreBinding.myToolbar.setVisibility(View.VISIBLE);
                    TranslateAnimation animate = new TranslateAnimation(
                            0,                 // fromXDelta
                            0,                 // toXDelta
                            -56,  // fromYDelta
                            0);                // toYDelta
                    animate.setDuration(200);
                    animate.setFillAfter(true);
                    activityStoreBinding.myToolbar.startAnimation(animate);
                }
                else if (scrollY < 260 && activityStoreBinding.myToolbar.getVisibility() == View.VISIBLE) {
                    TranslateAnimation animate = new TranslateAnimation(
                            0,                 // fromXDelta
                            0,                 // toXDelta
                            0,  // fromYDelta
                            -56);                // toYDelta
                    animate.setDuration(200);
                    animate.setFillAfter(true);
                    activityStoreBinding.myToolbar.startAnimation(animate);
                    new Timer().schedule(new TimerTask() {
                        @Override
                        public void run() {
                            activityStoreBinding.myToolbar.setVisibility(View.GONE);
                        }
                    }, 200);

                }
            }
        };
        
        activityStoreBinding.scrollview.getViewTreeObserver().addOnScrollChangedListener(scrollListner);
    }

    public int getStatusBarHeight() {
        int result = 0;
        int resourceId = getResources().getIdentifier("status_bar_height", "dimen", "android");
        if (resourceId > 0) {
            result = getResources().getDimensionPixelSize(resourceId);
        }
        return result;
    }

    private void addCategories() {
        storeCategories = new StoreCategories(model.getStoreData().getValue(), new TabLayout.OnTabSelectedListener() {
            @Override
            public void onTabSelected(TabLayout.Tab tab) {
                Log.v("tab", activityStoreBinding.tabLayout2.getTag()+"");
                Object tag = activityStoreBinding.tabLayout2.getTag();
                if (tag != null && tag.equals("select")) {
                    Log.v("tabbed", "select");
                    activityStoreBinding.tabLayout2.setTag("");
                    return;
                }
                TabLayout tabLayout = activityStoreBinding.storeScrollview.getChildAt(2).findViewById(R.id.tab_layout);
                Object tag2 = tabLayout.getTag();
                if (tag2 != null && tag2.equals("select")) {
                    Log.v("tabbed", "select");
                    tabLayout.setTag("");
                    return;
                }
                float categoriesy = activityStoreBinding.storeScrollview.getChildAt(2).getY();
                float categoriesh = tabLayout.getMeasuredHeight();
                float hugoh = ((LinearLayout)findViewById(R.id.pager)).getChildAt(0).getMeasuredHeight();
              //  activityStoreBinding.scrollview.getViewTreeObserver().removeOnScrollChangedListener(scrollListner);
                int tabIndex = tab.getPosition();
                activityStoreBinding.scrollview.smoothScrollTo(0, (int) (categoriesy - categoriesh + tab.getPosition()*hugoh));

                Log.v("tab", categoriesy+" "+categoriesh+" "+hugoh);

                Log.v("tab-3", tabLayout.getSelectedTabPosition()+" "+activityStoreBinding.tabLayout2.getSelectedTabPosition());

                if (tabLayout.getSelectedTabPosition() != tabIndex) {
                    tabLayout.selectTab(tabLayout.getTabAt(tab.getPosition()), true);
                }
                if (activityStoreBinding.tabLayout2.getSelectedTabPosition() != tabIndex) {
                    activityStoreBinding.tabLayout2.selectTab(activityStoreBinding.tabLayout2.getTabAt(tab.getPosition()), true);
                }
              //  activityStoreBinding.scrollview.getViewTreeObserver().addOnScrollChangedListener(scrollListner);

                //activityStoreBinding.scrollview.setScrollY();
            }

            @Override
            public void onTabUnselected(TabLayout.Tab tab) {

            }

            @Override
            public void onTabReselected(TabLayout.Tab tab) {

            }
        }, activityStoreBinding);
        fragmentTransaction.add(R.id.store_scrollview, storeCategories);
        model.getStoreData().observe(this, new Observer<HashMap<String, List<Product>>>() {
            @Override
            public void onChanged(HashMap<String, List<Product>> stringListHashMap) {
                //storeData.updateData(stringListHashMap);
            }
        });
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

    public static class StoreCategories extends Fragment {

        private HashMap<String, List<Product>> data;
        private StoreProductsBinding storeProductsBinding;
        private String[] keys;
        private TabLayout.OnTabSelectedListener onTabSelectedListner;
        private ActivityStoreHomeBinding activityStoreBinding;

        public StoreCategories(HashMap<String, List<Product>> data, TabLayout.OnTabSelectedListener listner, ActivityStoreHomeBinding storeBinding) {
            this.data = data;
            this.keys = new String[data.size()];
            this.data.keySet().toArray(keys);
            this.onTabSelectedListner = listner;
            this.activityStoreBinding = storeBinding;
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
            boolean selected = true;
            for (String key: keys) {
                storeProductsBinding.tabLayout.addTab(storeProductsBinding.tabLayout.newTab().setText(key), selected);
                activityStoreBinding.tabLayout2.addTab(activityStoreBinding.tabLayout2.newTab().setText(key), selected);
                selected = false;
            }
            storeProductsBinding.tabLayout.addOnTabSelectedListener(this.onTabSelectedListner);
            activityStoreBinding.tabLayout2.addOnTabSelectedListener(this.onTabSelectedListner);
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

    }

    public static class StoreData extends Fragment {

        private HashMap<String, List<Product>> data;
        private StoreProductsBinding storeProductsBinding;
        private String[] keys;
        private FragmentTransaction fragmentTransaction;

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
            //storeCategoriesAdapter = new StoreCategoriesAdapter(this, this.data);
            FragmentManager fragmentManager = getActivity().getSupportFragmentManager();
            fragmentTransaction = fragmentManager.beginTransaction();
            for (Map.Entry entry : this.data.entrySet()) {
                HugoList hugoList = new HugoList();
                hugoList.setData(new StoreProductsAdapter((List<Product>) entry.getValue(), getContext()), (String) entry.getKey());
                fragmentTransaction.add(R.id.pager, hugoList);
            }
            fragmentTransaction.commit();
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

    }
}