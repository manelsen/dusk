use v6.d;
use NativeCall;
use nqp;

unit class Dusk::Internal::Parser::Native;

constant LIBDUSK = %*ENV<DUSK_NATIVE_LIB> // '/home/micelio/git/Dusk/ext/simdjson/libdusk_native.so';

# C declarations
sub dusk_parse_init(Blob $data, size_t $len --> Pointer) is native(LIBDUSK) { * }
sub dusk_get_string(Pointer $ctx, Str $key --> Str) is native(LIBDUSK) { * }
sub dusk_get_array_size(Pointer $ctx, Str $key --> int64) is native(LIBDUSK) { * }
sub dusk_parse_free(Pointer $ctx) is native(LIBDUSK) { * }

# Helper class that implements RAII for the C pointer
class NativeDocument {
    has Pointer $.ctx;

    submethod DESTROY() {
        if $!ctx {
            dusk_parse_free($!ctx);
        }
    }
}

method parse($data, :$model) {
    return Any unless $data;
    
    my Blob $buf;
    if $data ~~ Buf {
        $buf = $data;
    } else {
        $buf = $data.encode('utf-8');
    }
    
    # Adicionamos padding exigido pelo simdjson (geralmente lida internamente, mas aqui passamos os bytes crus)
    my Pointer $ctx = dusk_parse_init($buf, $buf.elems);
    if !$ctx {
        die "Dusk::Error::InvalidJSON: Failed to parse native JSON";
    }
    
    # RAII binding: Raku garbage collector will free the C++ object when doc dies
    my $doc = NativeDocument.new(:$ctx);
    
    if $model.defined || ($model.^name ne 'Any' && $model.^name ne 'Mu') {
        # Prototype: only mapping name and skipping members parsing for the proof of concept
        # since full dynamic tree traversal in C would require more bindings.
        my $obj = $model.CREATE;
        
        my $name = dusk_get_string($ctx, 'name');
        if $name {
            $model.^attributes.first({ .name eq '$!name' }).set_value($obj, $name);
        }
        
        my $id = dusk_get_string($ctx, 'id');
        if $id {
            $model.^attributes.first({ .name eq '$!id' }).set_value($obj, $id);
        }
        
        return $obj;
    }
    
    return $doc;
}
