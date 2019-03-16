require 'data_uri'

class Forest::ProductsController < ForestLiana::ApplicationController

  def buyers
    limit = params['page']['size'].to_i
    offset = (params['page']['number'].to_i - 1) * limit

    orders = Product.find(params['product_id']).orders
    customers = orders.limit(limit).offset(offset).map(&:customer)
    count = orders.count

    render json: serialize_models(customers, {
      include: ['address'],
      meta: { count: count }
    })
  end

  def import_data
    uri = URI::Data.new(params.dig('data', 'attributes', 'values', 'CSV file'))

    CSV.parse(uri.data, { col_sep: ';' }).each do |row|
      price = 0
      case params.dig('data', 'attributes', 'values', 'Type')
      when 'phone'
        price = rand(300..1000) * 100
      when 'dress'
        price = rand(10..200) * 100
       when 'toy'
         price = rand(5..100) * 100
      end

      Product.create({
        label: row[0],
        price: price,
        picture: row[1].gsub('//i5.walmartimages.com/asr/', "//s3-#{ENV['S3_REGION']}.amazonaws.com/#{ENV['S3_BUCKET']}/livedemo/"),
      })
    end

    render json: { success: 'Data successfuly imported!' }
  end
end
