import pandas as pd


def get_race_by_merge(df, race_df, df_merge_col, race_merge_col, col_to_check_if_matched):
    _df = df.copy()
    _merge_col = "_merge_col"
    _race_df = race_df.copy()

    merge_1 = _df.merge(_race_df, how="left", left_on=df_merge_col, right_on=race_merge_col)

    non_match_1 = _df[merge_1[col_to_check_if_matched].isna()].copy().reset_index(drop=True)
    non_match_1[_merge_col] = non_match_1[df_merge_col] + " city"
    merge_2 = non_match_1.merge(_race_df, how="left", left_on=_merge_col, right_on=race_merge_col)

    non_match_2 = non_match_1[merge_2[col_to_check_if_matched].isna()].copy().reset_index(drop=True)
    non_match_2[_merge_col] = non_match_2[df_merge_col]
    non_match_2.loc[non_match_2["ID"] == "052038001", _merge_col] = "san francisco city"
    non_match_2.loc[non_match_2["ID"] == "052056005", _merge_col] = "san buenaventura (ventura) city"
    non_match_2.loc[non_match_2["ID"] == "052040002", _merge_col] = "el paso de robles (paso robles) city"
    merge_3 = non_match_2.merge(_race_df, how="left", left_on=_merge_col, right_on=race_merge_col)

    non_match_3 = non_match_2[merge_3[col_to_check_if_matched].isna()].copy().reset_index(drop=True)
    _race_df[race_merge_col] = _race_df[race_merge_col] + " city"
    merge_4 = non_match_3.merge(_race_df, how="left", left_on=df_merge_col, right_on=race_merge_col)

    assert merge_4[col_to_check_if_matched].isna().sum() == 0
    res = pd.concat([merge_1[~merge_1[col_to_check_if_matched].isna()],
                     merge_2[~merge_2[col_to_check_if_matched].isna()].drop(columns=_merge_col),
                     merge_3[~merge_3[col_to_check_if_matched].isna()].drop(columns=_merge_col),
                     merge_4.drop(columns=_merge_col)], ignore_index=True)
    assert res.shape[0] == _df.shape[0]

    return res.drop(columns=race_merge_col)
