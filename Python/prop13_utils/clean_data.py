

def normalize_str_cols(df, str_columns):
    for col in str_columns:
        df[col] = df[col].str.strip()
        df[col] = df[col].str.lower()
        df[col] = df[col].map(lambda x: None if x == "" else x)
