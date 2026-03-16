DECLARE
    v_dano_nevoa NUMBER := 10;
    v_novo_hp NUMBER;
    v_total_processados NUMBER := 0;
    v_total_caidos NUMBER := 0;

    CURSOR c_herois_ativos IS
        SELECT id_heroi, nome, hp_atual
        FROM TB_HEROIS
        WHERE status = 'ATIVO';

BEGIN
    FOR heroi IN c_herois_ativos LOOP
        v_novo_hp := heroi.hp_atual - v_dano_nevoa;

        IF v_novo_hp <= 0 THEN
            v_novo_hp := 0;

            UPDATE TB_HEROIS
            SET hp_atual = v_novo_hp,
                status = 'CAÍDO'
            WHERE id_heroi = heroi.id_heroi;

            v_total_caidos := v_total_caidos + 1;

            DBMS_OUTPUT.PUT_LINE('Herói ' || heroi.nome || ' caiu em batalha.');
        ELSE
            UPDATE TB_HEROIS
            SET hp_atual = v_novo_hp
            WHERE id_heroi = heroi.id_heroi;

            DBMS_OUTPUT.PUT_LINE('Herói ' || heroi.nome || ' atualizado para ' || v_novo_hp || ' HP');
        END IF;

        v_total_processados := v_total_processados + 1;
    END LOOP;

    DBMS_OUTPUT.PUT_LINE('Total de heróis processados: ' || v_total_processados);
    DBMS_OUTPUT.PUT_LINE('Total de heróis caídos: ' || v_total_caidos);
END;
/