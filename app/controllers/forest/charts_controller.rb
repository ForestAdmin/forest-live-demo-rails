class Forest::ChartsController < ForestLiana::ApplicationController
  def mrr
    mrr = 0

    from = Date.parse('2018-03-01').to_time(:utc).to_i
    to = Date.parse('2018-03-31').to_time(:utc).to_i

    Stripe::Charge.list({ 
      created: { gte: from, lte: to }, 
      limit: 100 
    }).each do |charge|
      mrr += charge.amount / 100
    end

    stat = ForestLiana::Model::Stat.new({ value: mrr })
    render json: serialize_model(stat)
  end

  def credit_card_country_repartition
    repartition = []

    from = Date.parse('2018-03-01').to_time(:utc).to_i
    to = Date.parse('2018-03-20').to_time(:utc).to_i

    Stripe::Charge.list({ 
      created: { gte: from, lte: to }, 
      limit: 100 
    }).each do |charge|
      country = charge.source.country || 'Others'

      entry = repartition.find { |e| e[:key] == country }
      if !entry
        repartition << { key: country, value: 1 }
      else
        ++entry[:value]
      end
    end

    stat = ForestLiana::Model::Stat.new({ value: repartition })
    render json: serialize_model(stat)
  end

  def charges_per_day
    values = []

    from = Date.parse('2018-03-01').to_time(:utc).to_i
    to = Date.parse('2018-03-31').to_time(:utc).to_i

    Stripe::Charge.list({ 
      created: { gte: from, lte: to }, 
      limit: 100 
    }).each do |charge|
      date = Time.at(charge.created).beginning_of_day.strftime("%d/%m/%Y")
      entry = values.find { |e| e[:label] == date }
      if !entry
        values << { label: date, values: { value: 1 } }
      else
        ++entry[:values][:value]
      end
    end

    stat = ForestLiana::Model::Stat.new({ value: values })
    render json: serialize_model(stat)
  end
end
