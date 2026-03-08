#include "simdjson.h"
#include <string>
#include <iostream>
#include <cstring>
#include <vector>

using namespace simdjson;

struct ParserContext {
    dom::parser parser;
    dom::element doc;
    std::string last_string;
};

extern "C" {

    void* dusk_parse_init(const char* json_data, size_t len) {
        if (!json_data || len == 0) return nullptr;
        
        ParserContext* ctx = new ParserContext();
        // O simdjson exige padding, mas padded_string faz a cópia segura
        try {
            auto error = ctx->parser.parse(json_data, len).get(ctx->doc);
            if (error) {
                delete ctx;
                return nullptr;
            }
        } catch (...) {
            delete ctx;
            return nullptr;
        }
        return ctx;
    }

    const char* dusk_get_string(void* ptr, const char* key) {
        if (!ptr || !key) return nullptr;
        ParserContext* ctx = static_cast<ParserContext*>(ptr);
        
        try {
            std::string_view val;
            auto error = ctx->doc[key].get(val);
            if (!error) {
                ctx->last_string = std::string(val);
                return ctx->last_string.c_str();
            }
        } catch (...) { }
        return nullptr;
    }

    void dusk_parse_free(void* ptr) {
        if (ptr) {
            delete static_cast<ParserContext*>(ptr);
        }
    }
}
