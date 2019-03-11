# frozen_string_literal: true

include ERB::Util

module OpendataParisApi
  def get_api_data(year, contract_type, job)
    uri = 'https://opendata.paris.fr/api/records/1.0/search/?'\
          'dataset=bilan-social-effectifs-non-titulaires-permanents&rows=1000'\
          "&refine.annee=#{year}"\
          "&refine.type_de_contrat=#{contract_type}"\
          "&refine.emplois=#{url_encode(job)}"

    RestClient.get(uri)
  end
end
