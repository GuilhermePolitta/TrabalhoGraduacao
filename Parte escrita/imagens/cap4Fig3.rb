class CreateAgendas < ActiveRecord::Migration
  def change
    create_table :agendas do |t|
      t.references :paciente, index: true
      t.references :profissional, index: true
      t.string :protocolo_registro_hora_entrada

      t.timestamps
    end
  end
end
