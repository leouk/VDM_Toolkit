package util;

import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Iterator;

public class NativeCSVParser extends AbstractCSVParser {

    public NativeCSVParser(CSVSettings settings)
    {
        super(settings);
    }
    
    // Idea from https://stackoverflow.com/questions/6857248/fast-csv-parsing
    // Use input streams for speed (instead of buffered reader)
    @Override
    protected Iterator<String[]> createIterator(final InputStream stream) throws IOException {
        return new Iterator<String[]>() {
            static final int UNCALCULATED = 0;
            static final int READY = 1;
            static final int FINISHED = 2;
            int state = UNCALCULATED;
            final ArrayList<String> value_list = new ArrayList<>();
            final StringBuilder sb = new StringBuilder();
            String[] return_value;

            public void end() {
                end_part();
                return_value = new String[value_list.size()];
                value_list.toArray(return_value);
                value_list.clear();
            }

            public void end_part() {
                value_list.add(sb.toString());
                sb.setLength(0);
            }

            public void append(int ch) {
                sb.append((char) ch);
            }

            public void calculate() throws IOException {
                boolean inquote = false;
                while (true) {
                    int ch = stream.read();
                    switch (ch) {
                        default: //regular character.
                            append(ch);
                            break;
                        case -1: //read has reached the end.
                            if ((sb.length() == 0) && (value_list.isEmpty())) {
                                state = FINISHED;
                            } else {
                                end();
                                state = READY;
                            }
                            return;
                        case '\r':
                        case '\n': //end of line.
                            if (inquote) {
                                append(ch);
                            } else {
                                end();
                                state = READY;
                                return;
                            }
                            break;
                        case ',': //comma
                            if (inquote) {
                                append(ch);
                            } else {
                                end_part();
                                break;
                            }
                            break;
                        case '"': //quote.
                            inquote = !inquote;
                            break;
                        //@TODO case '#' for CSV comments till \n?
                    }
                }
            }

            @Override
            public boolean hasNext() {
                if (state == UNCALCULATED) {
                    try {
                        calculate();
                    } catch (IOException ex) {
                        lastErrorStr = "CSV-IO: " + ex.getMessage();
                    }
                }
                return state == READY;
            }

            @Override
            public String[] next() {
                if (state == UNCALCULATED) {
                    try {
                        calculate();
                    } catch (IOException ex) {
                        lastErrorStr = "CSV-IO: " + ex.getMessage();
                    }
                }
                state = UNCALCULATED;
                return return_value;
            }
        };
    }
}

