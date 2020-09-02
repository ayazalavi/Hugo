package com.hugo.views;

import android.os.Bundle;

import com.hugo.R;
import com.hugo.databinding.ActivitySearchResultBinding;
import com.hugo.helpers.HugoList;
import com.hugo.helpers.ProductList;
import com.hugo.helpers.ProductsAdapter;
import com.hugo.helpers.SearchFiltersAdapter;
import com.hugo.helpers.StoreAdapter;
import com.hugo.viewmodels.Product;
import com.hugo.viewmodels.SearchResultFilter;
import com.hugo.viewmodels.SearchResultViewModel;
import com.hugo.viewmodels.Store;

import androidx.appcompat.app.AppCompatActivity;
import androidx.fragment.app.FragmentManager;
import androidx.fragment.app.FragmentTransaction;
import androidx.lifecycle.Observer;
import androidx.lifecycle.ViewModelProvider;

import android.view.View;
import android.view.Menu;
import android.view.MenuItem;

import java.util.List;

public class SearchResult extends AppCompatActivity implements Navigation.OnActivityCreated {

    private ActivitySearchResultBinding activitySearchBinding;
    private SearchResultViewModel model;
    private FragmentTransaction fragmentTransaction;
    private HugoList filterList;
    private HugoList hugoListList;
    private Navigation navigation;
    private ProductList productsList;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        activitySearchBinding = ActivitySearchResultBinding.inflate(getLayoutInflater());
        View view = activitySearchBinding.getRoot();
        setContentView(view);

        model = new ViewModelProvider(this).get(SearchResultViewModel.class);
        model.setContext(this);

        FragmentManager fragmentManager = getSupportFragmentManager();
        fragmentTransaction = fragmentManager.beginTransaction();
        addNavigation();
        addFilters();
        addBrands();
        addProducts();
        fragmentTransaction.commit();

    }

    private void addProducts() {
        productsList = new ProductList("PRODUCTOS SUPERMERCADO", model.getProductsData().getValue());
        fragmentTransaction.add(R.id.search_scrollview, productsList);
        model.getProductsData().observe(this, new Observer<List<Product>>() {
            @Override
            public void onChanged(List<Product> products) {
            }
        });
    }

    @Override
    public void setNavigation() {
        navigation.setNavigationSettings(new Navigation.NavigationSettings("RESULTADO DE BÚSQUEDA", R.style.AppTheme_NavigationTitleSearch, true, R.drawable.close_icon_top_bar, false , 0));
        navigation.setSearchBarFocus(false);
        navigation.setSearchBarClickListner(new View.OnClickListener() {
            @Override
            public void onClick(View v) {

            }
        }, false);
    }

    private void addNavigation() {
        navigation = new Navigation();
        fragmentTransaction.add(R.id.search_scrollview, navigation); //
    }

    private void addBrands() {
        hugoListList = new HugoList();
        fragmentTransaction.add(R.id.search_scrollview, hugoListList);
        model.getSearchStoreData().observe(this, new Observer<List<Store>>() {
            @Override
            public void onChanged(List<Store> stores) {
                hugoListList.setTitle("POPULARES");
                hugoListList.hideViewMore();
                hugoListList.setDataAdapter(new StoreAdapter(stores, SearchResult.this));
            }
        });
    }

    private void addFilters() {
        filterList = new HugoList();
        fragmentTransaction.add(R.id.search_scrollview, filterList);

        model.getSearchFilters().observe(this, new Observer<List<SearchResultFilter>>() {
            @Override
            public void onChanged(List<SearchResultFilter> searchResultFilters) {
                filterList.hideTitle();
                filterList.hideViewMore();
                filterList.setDataAdapter(new SearchFiltersAdapter(searchResultFilters, SearchResult.this));
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

    public void goBack(View view) {
        finish();

    }
}