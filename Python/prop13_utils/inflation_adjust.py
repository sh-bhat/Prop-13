import pkg_resources
from os import path
from typing import Dict

import pandas as pd


class InflationAdj:
    def __init__(self):
        """
        https://data.bls.gov/timeseries/CUUR0000SA0
        """

        cpi_map_filenamme = "SeriesReport-20211210164341_306546.xlsx"
        month = "Jun"

        cpi_map_file = pkg_resources.resource_stream(__name__, path.join("data", cpi_map_filenamme))
        _df = pd.read_excel(cpi_map_file,
                            skiprows=11,
                            converters={"Year": lambda x: str(int(x))})

        _df = _df[["Year", month]].copy()
        _df = _df[~_df.isna()].copy().set_index("Year")
        self.cpi_map = _df.to_dict("dict")[month]

    def _get_inflation_adj_factor_map(self, base_yr: str) -> Dict[str, float]:
        """Convert CPI to Inflation Adjustment Factor. The inflation adjusted value is determined by multiplying
        its original value by Inflation Adjustment Factor.

        Returns:
            A dict mapping year to Inflation Adjustment Factor.
        """

        if base_yr not in self.cpi_map:
            raise Exception(f"No CPI found in {base_yr}.")

        return {yr: self.cpi_map[base_yr] / self.cpi_map[yr] for yr in self.cpi_map}

    def inflation_adjust_df_money_col(self, df, yr_col: str, money_col: str, base_yr: str):
        """Convert the dollar's value in <yr_col> to the dollar's value in <base_yr> by CPI.

        Returns:
            A dataframe with inflation adjusted values.
        """

        _df = df.copy()
        inflation_factor_map = self._get_inflation_adj_factor_map(base_yr)
        _df[money_col] = _df[money_col] * df[yr_col].map(inflation_factor_map)

        return _df
