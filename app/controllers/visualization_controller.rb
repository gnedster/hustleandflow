class VisualizationController < ApplicationController
  caches_page :index, :gzip => :best_speed
  def index
    judges = Judge.select{ |j| j.total_value > 0 }
    .sort_by!{ |j| j.total_value * -1 }
    donors = Donor.select{ |d| d.total_value > 0 }
    .sort_by!{ |d| d.total_value * -1 }

    gon.maxTotalValue = [judges.first.total_value, donors.first.total_value].max

    gon.judges = Hash[judges
      .map! { |j| [j.id, {'id' => j.id,
        'name' => j.full_name,
        'group' => 2,
        'totalValue' => j.total_value,
        'giftCount' => j.gift_count,
        'url' => judge_path(j)
      }]}
    ]

    gon.donors = Hash[donors
        .map! { |d| [d.id, { 'id' => d.id,
          'name' => d.name,
          'group' => 1,
          'totalValue' => d.total_value,
          'giftCount' => d.gift_count,
          'url' => donor_path(d)
        }]
      }
    ]

    gon.links = Gift.where('judge_id IS NOT NULL AND donor_id IS NOT NULL AND value IS NOT NULL')
      .map! { |g| {'source' => g.donor_id, 'target' => g.judge_id, 'value' => g.value }}

    respond_to do |format|
      format.html # index.html.erb
    end
  end
end
