package com.hugo.helpers;

import android.content.Context;
import android.os.Bundle;
import android.text.Spannable;
import android.text.SpannableString;
import android.text.style.TextAppearanceSpan;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.fragment.app.Fragment;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import com.hugo.R;
import com.hugo.databinding.FragmentBrandBinding;
import com.hugo.databinding.FragmentProductBinding;
import com.hugo.databinding.ProductStoreCardBinding;
import com.hugo.viewmodels.HomeBrand;
import com.hugo.viewmodels.Product;

import java.util.List;


public class ProductList extends Fragment {

    private List<Product> data;
    private String title;
    private FragmentProductBinding brand;

    public ProductList(String title, List<Product> products) {
        super();
        this.title = title;
        this.data = products;
    }

    public void setProducts(List<Product> products) {
        this.data = products;
        for (int i=0; i<4; i++) {
            Product product = products.get(i);
            SpannableString text1 = new SpannableString(product.price);
            SpannableString text2 = new SpannableString(product.title);
            SpannableString text3 = new SpannableString(product.subtitle);
            SpannableString text = new SpannableString(text1+"\n"+text2+"\n"+text3);
            text.setSpan(new TextAppearanceSpan(getActivity(), R.style.AppTheme_ProductPrice), 0, text1.length(), Spannable.SPAN_EXCLUSIVE_EXCLUSIVE);
            text.setSpan(new TextAppearanceSpan(getActivity(), R.style.AppTheme_ProductName), text1.length(), text1.length()+text2.length(), Spannable.SPAN_EXCLUSIVE_EXCLUSIVE);
            text.setSpan(new TextAppearanceSpan(getActivity(), R.style.AppTheme_ProductSubText), text1.length()+text2.length(), text.length(), Spannable.SPAN_EXCLUSIVE_EXCLUSIVE);
            product.titleThemed = text;
            switch (i) {
                case 0: {
                    brand.setProduct1(product);
                    break;
                }
                case 1: {
                    brand.setProduct2(product);
                    break;
                }
                case 2: {
                    brand.setProduct3(product);
                    break;
                }
                case 3: {
                    brand.setProduct4(product);
                    break;
                }
            }
        }
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
        brand = FragmentProductBinding.inflate(inflater, container, false);
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
        setTitle(this.title);
        setProducts(this.data);
    }


    public void hideViewMore() {
        brand.viewMore.setVisibility(View.GONE);
    }

    public void hideTitle() {
        brand.listTitle.setVisibility(View.GONE);
    }

    public void setTitle(String title) {
        brand.setTitle(title);
    }

}