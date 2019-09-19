class AddAlbums < ActiveRecord::Migration[6.0]
  def up
    Album.create(
      name: 'Brasileirão 2019 Séries A e B',
      description: 'Álbum Oficial do Campeonato Brasileiro 2019 Séries A e B',
      number_of_stickers: 450
    )
    Album.create(
      name: 'Flamengo Smpre Eu Hei de Ser',
      description: 'Álbum Oficial do Flamengo',
      number_of_stickers: 300
    )
    Album.create(
      name: 'LOL Surprise 2 - Vamos Ser Amigos',
      description: 'Álbum Oficial LOL Surprise 2 - Vamos Ser Amigos',
      number_of_stickers: 400 # chutei
    )
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
