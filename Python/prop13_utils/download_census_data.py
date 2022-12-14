import censusdata

from prop13_utils.clean_data import normalize_str_cols


class CACensusData:
    """
    Download census data via pkg: CensusData.
    Available for:
        ACS 5-year estimates (2005-2009 to 2015-2019),
        ACS 1-year estimates (2012-2019),
        ACS 3-year estimates (2010-2012 to 2011-2013),
        ACS 1-year supplemental estimates (2014-2019),
        Census 2010 Summary File 1.
    """
    CA_FIPS_code = '06'

    def get_census_data_by_place(self, survey_name, year, indicator_map):
        """

        Args:
            survey_name: str
            year: int
            indicator_map: dict[str, list[str]], the key is user-defined and human-readable column name and the value is
            variable names (code) from Census Data API.

        Returns: pandas.DataFrame with cols: "place_name", human-readable column names suffixed with "_<year>"

        """
        variable_ids = list()
        for _, variables in indicator_map.items():
            variable_ids += variables

        df = censusdata.download(
            survey_name, year,
            censusdata.censusgeo([('state', "06"), ('place', "*")]),
            variable_ids
        )

        for i, v in indicator_map.items():
            if len(v) == 1:  # variable directly used for indicator
                df[i] = df[v[0]]
            elif len(v) > 1:  # aggregate by summing up multiple variables
                df[i] = df[v].sum(axis=1)
        df = df.drop(columns=variable_ids)

        df = df.reset_index()

        df["place_name"] = df["index"].map(lambda g: g.__dict__["name"])
        normalize_str_cols(df, ["place_name"])
        df["place_name"] = df["place_name"].str.replace(r", california$", "", regex=True)

        return df.rename(columns={col: f"{col}_{str(year)}" for col in indicator_map})
