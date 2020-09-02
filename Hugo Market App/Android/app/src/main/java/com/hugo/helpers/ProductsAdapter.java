package com.hugo.helpers;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.ViewGroup;

import androidx.recyclerview.widget.RecyclerView;

import com.hugo.viewmodels.HomeProduct;
import com.hugo.databinding.HomeProductsCardBinding;

import java.util.List;

public class ProductsAdapter extends RecyclerView.Adapter<ProductsAdapter.ViewHolder> {

    private final List<HomeProduct> mValues;
    private Context ctx;

    public ProductsAdapter(List<HomeProduct> items, Context context) {
        mValues = items;
        this.ctx = context;
    }

    @Override
    public ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        LayoutInflater layoutInflater = LayoutInflater.from(parent.getContext());
        HomeProductsCardBinding itemBinding = HomeProductsCardBinding.inflate(layoutInflater, parent, false);
        return new ViewHolder(itemBinding);
    }

    @Override
    public void onBindViewHolder(final ViewHolder holder, int position) {
        HomeProduct item = mValues.get(position);
        holder.bind(item, ctx);
    }

    @Override
    public int getItemCount() {
        return mValues.size();
    }

    public class ViewHolder extends RecyclerView.ViewHolder {
        private final HomeProductsCardBinding binding;

        public ViewHolder(HomeProductsCardBinding binding) {
            super(binding.getRoot());
            this.binding = binding;
        }

        public void bind(HomeProduct item, Context context) {
            final int resourceId = context.getResources().getIdentifier(item.photo, "drawable", context.getPackageName());
            binding.productPhoto.setImageDrawable(context.getResources().getDrawable(resourceId));
            binding.title.setText(item.title);
            binding.subtitle.setText(item.subtitle);
        }
    }
}