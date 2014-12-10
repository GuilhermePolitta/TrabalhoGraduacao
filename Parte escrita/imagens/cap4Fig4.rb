class Agenda < ActiveRecord::Base
  belongs_to :paciente
  belongs_to :profissional
end
