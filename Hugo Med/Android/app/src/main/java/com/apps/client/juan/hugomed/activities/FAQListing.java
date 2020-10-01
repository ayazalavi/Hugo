package com.apps.client.juan.hugomed.activities;

import android.content.Context;
import android.os.Bundle;
import android.text.SpannableString;
import android.text.SpannedString;
import android.text.TextUtils;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.BaseAdapter;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;
import androidx.core.content.ContextCompat;
import androidx.databinding.BindingAdapter;
import androidx.lifecycle.Observer;
import androidx.lifecycle.ViewModelProvider;
import androidx.recyclerview.widget.RecyclerView;

import com.apps.client.juan.hugomed.R;
import com.apps.client.juan.hugomed.data.entities.Doctor;
import com.apps.client.juan.hugomed.data.entities.FAQ;
import com.apps.client.juan.hugomed.data.helpers.HugoMedDatabase;
import com.apps.client.juan.hugomed.data.viewmodels.DoctorsViewModel;
import com.apps.client.juan.hugomed.data.viewmodels.FAQViewModel;
import com.apps.client.juan.hugomed.databinding.DoctorsCardOfflineBinding;
import com.apps.client.juan.hugomed.databinding.DoctorsCardOnlineBinding;
import com.apps.client.juan.hugomed.databinding.DoctorslistingBinding;
import com.apps.client.juan.hugomed.databinding.FaqBinding;
import com.apps.client.juan.hugomed.databinding.FaqItemBinding;
import com.apps.client.juan.hugomed.helpers.SpannableHelper;

import java.lang.reflect.Array;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

public class FAQListing extends AppCompatActivity {
    private FaqBinding faqBinding;
    private Runnable runnable;
    private FAQViewModel viewModel;
    private Adapter adapter;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.faq);

        faqBinding = FaqBinding.inflate(getLayoutInflater());
        setContentView(faqBinding.getRoot());

        runnable = new Runnable() {
            @Override
            public void run() {
                viewModel.getALLFAQs().observe(FAQListing.this, new Observer<List<FAQ>>() {
                    @Override
                    public void onChanged(List<FAQ> faqs) {
                        Collections.sort(faqs, (o1, o2) -> {
                            return (int) (o1.id - o2.id);
                        });
                        adapter.mFaqs = faqs;
                        adapter.notifyDataSetChanged();
                    }
                });
            }
        };
        HugoMedDatabase.databaseWriteExecutor.execute(() -> {
            viewModel = new ViewModelProvider(this).get(FAQViewModel.class);
            runOnUiThread(runnable);
        });
        adapter = new FAQListing.Adapter(this, (faq, itemBinding) -> {
            if (itemBinding.getShowDetails()) {
                itemBinding.setShowDetails(false);
            } else {
                itemBinding.setShowDetails(true);
            }
        });
        faqBinding.faq.setAdapter(adapter);

        setSupportActionBar(faqBinding.myToolbar);
        getSupportActionBar().setDisplayShowTitleEnabled(false);
        faqBinding.myToolbar.setNavigationOnClickListener(v -> {
            finish();
        });
    }

    @BindingAdapter("android:src")
    public static void setImageResource(ImageView imageView, int resource){
        imageView.setImageResource(resource);
    }

    class Adapter extends RecyclerView.Adapter<Adapter.ViewHolder> {
        private final OnItemClickListener onItemClickListner;
        private class ViewHolder extends RecyclerView.ViewHolder {
            private FaqItemBinding faqItemBinding;

            public ViewHolder(FaqItemBinding itemBinding) {
                super(itemBinding.getRoot());
                faqItemBinding = itemBinding;
            }

            public void bind(FAQ faq, OnItemClickListener clickListener) {
                faqItemBinding.setData(faq);
                faqItemBinding.setShowDetails(false);
                itemView.setOnClickListener(v -> {
                    clickListener.onItemClicked(faq, faqItemBinding);
                });
            }
        }
        public List<FAQ> mFaqs;
        private Context mContext;

        Adapter(Context context, OnItemClickListener clickListener) {
            mContext = context;
            mFaqs = new ArrayList<FAQ>();
            onItemClickListner = clickListener;
        }

        @NonNull
        @Override
        public ViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
            FaqItemBinding faqItemBinding = FaqItemBinding.inflate(getLayoutInflater());
            return new ViewHolder(faqItemBinding);
        }

        @Override
        public void onBindViewHolder(@NonNull ViewHolder holder, int position) {
            holder.bind(mFaqs.get(position), onItemClickListner);
        }

        @Override
        public long getItemId(int position) {
            return mFaqs.get(position).id;
        }

        @Override
        public int getItemCount() {
            return mFaqs.size();
        }

    }

    interface OnItemClickListener {
        void onItemClicked(FAQ faq, FaqItemBinding itemBinding);
    }
}