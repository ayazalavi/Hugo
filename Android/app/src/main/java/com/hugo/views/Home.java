package com.hugo.views;

import android.content.Intent;
import android.os.Bundle;

import com.hugo.helpers.BrandAdapter;
import com.hugo.helpers.HomeStoreAdapter;
import com.hugo.helpers.HugoList;
import com.hugo.helpers.ProductList;
import com.hugo.helpers.ProductsAdapter;
import com.hugo.helpers.StoreAdapter;
import com.hugo.R;
import com.hugo.viewmodels.HomeBanner;
import com.hugo.viewmodels.HomeBrand;
import com.hugo.viewmodels.HomeProduct;
import com.hugo.viewmodels.HomeStore;
import com.hugo.viewmodels.HomeViewModel;
import com.hugo.viewmodels.Product;
import com.hugo.viewmodels.Store;
import com.hugo.databinding.ActivityHomeBinding;
import com.hugo.databinding.SearchBarBinding;

import androidx.appcompat.app.AppCompatActivity;
import androidx.fragment.app.FragmentManager;
import androidx.fragment.app.FragmentTransaction;
import androidx.lifecycle.Observer;
import androidx.lifecycle.ViewModelProvider;

import android.view.View;
import android.view.Menu;
import android.view.MenuItem;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class Home extends AppCompatActivity implements Navigation.OnActivityCreated {

    private ActivityHomeBinding home;
    public static SearchBarBinding search;
    private HomeViewModel model;
    private Banner banner;
    private FragmentTransaction fragmentTransaction;
    private HugoList hugoList;
    private HugoList storeBrands;
    private HugoList products;
    private HugoList stores;
    private Navigation navigation;
    private ProductList[] categoryList;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        home = ActivityHomeBinding.inflate(getLayoutInflater());
        View view = home.getRoot();
        setContentView(view);

        model = new ViewModelProvider(this).get(HomeViewModel.class);
        model.setContext(this);

        FragmentManager fragmentManager = getSupportFragmentManager();
        fragmentTransaction = fragmentManager.beginTransaction();
        addNavigation();
        addBanner();
        addBrands();
        addProducts();
        addStores();
        addStoreBrands();
        addProductsCategory();
        fragmentTransaction.commit();
    }

    @Override
    public void setNavigation() {
        navigation.setNavigationSettings(new Navigation.NavigationSettings("hugo", R.style.AppTheme_NavigationTitleHome, false, 0, true , R.drawable.icon_top_bar));
        navigation.setSearchBarClickListner(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent intent = new Intent(Home.this, Search.class);
                startActivity(intent);
            }
        }, false);
        navigation.setSearchBarFocus(false);
    }

    private void addNavigation() {
        navigation = new Navigation();
        fragmentTransaction.add(R.id.home_scrollview, navigation);
    }

    private void addProductsCategory() {

        for(Map.Entry<String, List<Product>> category: model.getProductCategoryData().getValue().entrySet()){
            ProductList list = new ProductList(category.getKey(), category.getValue());
            fragmentTransaction.add(R.id.home_scrollview, list);
        }
        model.getProductCategoryData().observe(this, new Observer<HashMap<String, List<Product>>>() {
            @Override
            public void onChanged(HashMap<String, List<Product>> stringListHashMap) {
                //categoryList = new ProductList[stringListHashMap.size()];

            }
        });
    }

    private void addStoreBrands() {
        storeBrands = new HugoList();
        fragmentTransaction.add(R.id.home_scrollview, storeBrands);


        model.getStoreBrandData().observe(this, new Observer<List<Store>>() {
            @Override
            public void onChanged(List<Store> stores) {
                storeBrands.setTitle("NUEVOS RESTAURANTES");
                storeBrands.setDataAdapter(new StoreAdapter(stores, Home.this));
            }
        });
    }

    private void addStores() {
        stores = new HugoList();
        fragmentTransaction.add(R.id.home_scrollview, stores);


        model.getHomeStoreData().observe(this, new Observer<List<HomeStore>>() {
            @Override
            public void onChanged(List<HomeStore> homeStores) {
                stores.setTitle("PROMOCIONES");
                stores.hideViewMore();
                stores.setDataAdapter(new HomeStoreAdapter(homeStores, Home.this));
            }
        });
    }

    private void addProducts() {
        products = new HugoList();
        fragmentTransaction.add(R.id.home_scrollview, products);


        model.getHomeProductData().observe(this, new Observer<List<HomeProduct>>() {
            @Override
            public void onChanged(List<HomeProduct> homeProducts) {
                products.setTitle("SUMMER PRODUCTS");
                products.setDataAdapter(new ProductsAdapter(homeProducts, Home.this));
            }
        });

    }

    private void addBrands() {
        hugoList = new HugoList();
        fragmentTransaction.add(R.id.home_scrollview, hugoList);


        model.getHomeBrandData().observe(this, new Observer<List<HomeBrand>>() {
            @Override
            public void onChanged(List<HomeBrand> homeBrands) {
                hugoList.setTitle("DESTACADOS EN LIFESTYLE");
                hugoList.setDataAdapter(new BrandAdapter(homeBrands, Home.this));
            }
        });
    }

    private void addBanner() {
        banner = new Banner();
        fragmentTransaction.add(R.id.home_scrollview, banner);

        model.getHomeBannerData().observe(this, new Observer<HomeBanner>() {
            @Override
            public void onChanged(HomeBanner homeBanner) {
                banner.setData(homeBanner);
            }
        });
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
}