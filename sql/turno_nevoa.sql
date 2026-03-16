DECLARE
    v_dano_nevoa NUMBER := 10;
    v_novo_hp NUMBER;
    v_total_processados NUMBER := 0;

    CURSOR c_herois_ativos IS
        SELECT id_heroi, nome, hp_atual
        FROM TB_HEROIS
        WHERE status = 'ATIVO';

BEGIN
    FOR heroi IN c_herois_ativos LOOP
        v_novo_hp := heroi.hp_atual - v_dano_nevoa;

        UPDATE TB_HEROIS
        SET hp_atual = v_novo_hp
        WHERE id_heroi = heroi.id_heroi;

        v_total_processados := v_total_processados + 1;

        DBMS_OUTPUT.PUT_LINE('Herói ' || heroi.nome || ' atualizado para ' || v_novo_hp || ' HP');
    END LOOP;

    DBMS_OUTPUT.PUT_LINE('Total de heróis processados: ' || v_total_processados);
END;
/