-- Crear la función para actualizar el timestamp
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Crear el trigger para la tabla "User"
CREATE TRIGGER user_update
BEFORE UPDATE ON "User"
FOR EACH ROW
EXECUTE FUNCTION update_updated_at_column();

-- Crear el trigger para la tabla "File"
CREATE TRIGGER file_update
BEFORE UPDATE ON "File"
FOR EACH ROW
EXECUTE FUNCTION update_updated_at_column();

-- Crear el trigger para la tabla "Movie"
CREATE TRIGGER movie_update
BEFORE UPDATE ON "Movie"
FOR EACH ROW
EXECUTE FUNCTION update_updated_at_column();

-- Crear el trigger para la tabla "Person"
CREATE TRIGGER person_update
BEFORE UPDATE ON "Person"
FOR EACH ROW
EXECUTE FUNCTION update_updated_at_column();

-- Crear el trigger para la tabla "Character"
CREATE TRIGGER character_update
BEFORE UPDATE ON "Character"
FOR EACH ROW
EXECUTE FUNCTION update_updated_at_column();

-- Crear el trigger para la tabla "Genre"
CREATE TRIGGER genre_update
BEFORE UPDATE ON "Genre"
FOR EACH ROW
EXECUTE FUNCTION update_updated_at_column();

-- Crear el trigger para la tabla "MovieGenre"
CREATE TRIGGER moviegenre_update
BEFORE UPDATE ON "MovieGenre"
FOR EACH ROW
EXECUTE FUNCTION update_updated_at_column();

-- Crear el trigger para la tabla "FavoriteMovie"
CREATE TRIGGER favoritemovie_update
BEFORE UPDATE ON "FavoriteMovie"
FOR EACH ROW
EXECUTE FUNCTION update_updated_at_column();

-- Crear el trigger para la tabla "Country"
CREATE TRIGGER country_update
BEFORE UPDATE ON "Country"
FOR EACH ROW
EXECUTE FUNCTION update_updated_at_column();
