class FinancialDatum < ApplicationRecord
  belongs_to :user
  attr_accessor :kind
  enum kind: {  
    "Others" => 0,  
    "Diet" => 1, 
    "Traffic" => 2, 
    "Daily necessities" =>3,
    "Entertainment" => 4
  } 
  validates :details, presence: true, length: { maximum: 50 }
  validates :money, numericality: true, presence: true, length: { maximum: 50 }
  validates :kind, inclusion: kinds.keys ,presence: true, length: { maximum: 50 }
  

    

 
end
