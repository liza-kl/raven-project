package cwi.masterthesis.raven.interpreter.mapper.stylingstrategy;


public class PrimitiveTypeConverter {


    public Object getConverter(String type, String value) {
        PrimitiveTypeConverter.PrimitiveTypes property = PrimitiveTypeConverter.PrimitiveTypes.valueOf(type.toUpperCase());
        return property.getConverter(value);
    }

    private enum PrimitiveTypes {
        BOOLEAN {
            @Override
            Object getConverter(String value) {
                return Boolean.parseBoolean(value);
            }
        },
        BYTE {
            @Override
            Object getConverter(String value) {
                return Byte.parseByte(value);
            }
        },
        SHORT {
            @Override
            Object getConverter(String value) {
                return Short.parseShort(value);
            }
        },
        INT {
            @Override
            Object getConverter(String value) {
                return Integer.parseInt(value);
            }
        },
        LONG {
            @Override
            Object getConverter(String value) {
                return Long.parseLong(value);
            }
        },
        FLOAT {
            @Override
            Object getConverter(String value) {
                return Float.parseFloat(value);
            }
        },
        DOUBLE {
            @Override
            Object getConverter(String value) {
                return Double.parseDouble(value);
            }
        };
        abstract Object getConverter(String value);

        };

}
