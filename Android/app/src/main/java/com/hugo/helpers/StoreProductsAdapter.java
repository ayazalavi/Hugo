package com.hugo.helpers;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.ViewGroup;

import androidx.recyclerview.widget.RecyclerView;

import com.hugo.databinding.HomeProductsCardBinding;
import com.hugo.databinding.StoreProductsCardBinding;
import com.hugo.viewmodels.HomeProduct;
import com.hugo.viewmodels.Product;

import java.util.List;

public class StoreProductsAdapter extends RecyclerView.Adapter<StoreProductsAdapter.ViewHolder> {

    private final List<Product> mValues;
    private Context ctx;

    public StoreProductsAdapter(List<Product> items, Context context) {
        mValues = items;
        this.ctx = context;
    }

    @Override
    public ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        LayoutInflater layoutInflater = LayoutInflater.from(parent.getContext());
        StoreProductsCardBinding itemBinding = StoreProductsCardBinding.inflate(layoutInflater, parent, false);
        return new ViewHolder(itemBinding);
    }

    @Override
    public void onBindViewHolder(final ViewHolder holder, int position) {
        Product item = mValues.get(position);
        holder.bind(item, ctx);
    }

    @Override
    public int getItemCount() {
        return mValues.size();
    }

    public class ViewHolder extends RecyclerView.ViewHolder {
        private final StoreProductsCardBinding binding;

        public ViewHolder(StoreProductsCardBinding binding) {
            super(binding.getRoot());
            this.binding = binding;
        }

        public void bind(Product item, Context context) {
            this.binding.setProduct(item);
        }
    }
}