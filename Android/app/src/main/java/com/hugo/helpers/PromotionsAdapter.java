package com.hugo.helpers;

import android.content.Context;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.ViewGroup;
import android.widget.ImageView;

import androidx.databinding.BindingAdapter;
import androidx.recyclerview.widget.RecyclerView;

import com.hugo.databinding.PromotionListItemBinding;
import com.hugo.databinding.SearchFilterBinding;
import com.hugo.viewmodels.SearchResultFilter;
import com.hugo.viewmodels.StorePromotions;

import java.util.List;

public class PromotionsAdapter extends RecyclerView.Adapter<PromotionsAdapter.ViewHolder> {

    private final List<StorePromotions> mValues;
    private static Context ctx;

    public PromotionsAdapter(List<StorePromotions> items, Context context) {
        mValues = items;
        this.ctx = context;
    }

    @Override
    public ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        LayoutInflater layoutInflater = LayoutInflater.from(parent.getContext());
        PromotionListItemBinding itemBinding = PromotionListItemBinding.inflate(layoutInflater, parent, false);
        return new ViewHolder(itemBinding);
    }

    @Override
    public void onBindViewHolder(final ViewHolder holder, int position) {
        StorePromotions item = mValues.get(position);
        holder.bind(item, ctx);
    }

    @Override
    public int getItemCount() {
        return mValues.size();
    }

    public class ViewHolder extends RecyclerView.ViewHolder {
        private final PromotionListItemBinding binding;

        public ViewHolder(PromotionListItemBinding binding) {
            super(binding.getRoot());
            this.binding = binding;
        }

        public void bind(StorePromotions item, Context context) {
            this.binding.setPromotion(item);
        }


    }
}